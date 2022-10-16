package com.karma.voucher.batch;

import com.karma.voucher.model.voucher.VoucherEntity;
import com.karma.voucher.model.voucher.VoucherStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.database.JpaCursorItemReader;
import org.springframework.batch.item.database.JpaItemWriter;
import org.springframework.batch.item.database.builder.JpaCursorItemReaderBuilder;
import org.springframework.batch.item.database.builder.JpaItemWriterBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.persistence.EntityManagerFactory;
import java.time.LocalDateTime;
import java.util.Map;

@Configuration
@RequiredArgsConstructor
public class ExpireVoucherConfig {

    // application.yaml 파일에서 설정한 custom-config
//    @Value("${custom-config.batch.chunk_size}") private final int chunk_size;
    private final int chunk_size = 5;
    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;
    private final EntityManagerFactory entityManagerFactory;

    @Bean
    public Job expireVoucherJob(){
        return this.jobBuilderFactory
                .get("expireVoucherJob")
                .start(expireVoucherStep())
                .build();
    }

    @Bean
    @StepScope
    public JpaCursorItemReader<VoucherEntity> expirePassesItemReader() {
        String query = "select ve " +
                "from VoucherEntity ve " +
                "where ve.voucherStatus = :status and ve.endedAt <= :endedAt order by ve.id";
        return new JpaCursorItemReaderBuilder<VoucherEntity>()
                .name("expirePassesItemReader")
                .entityManagerFactory(entityManagerFactory)
                .queryString(query)
                .parameterValues(Map.of(
                        "voucherStatus", VoucherStatus.PROGRESSED,
                        "endAt", LocalDateTime.now()))
                .build();
    }

    @Bean
    public ItemProcessor<VoucherEntity, VoucherEntity> expireVoucherItemProcessor(){
        return voucherEntity -> {
            voucherEntity.setStatus(VoucherStatus.EXPIRED);
            voucherEntity.setExpiredAt(LocalDateTime.now());
            return voucherEntity;
        };
    }

    @Bean
    public JpaItemWriter<VoucherEntity> expireVoucherJpaItemWriter(){
        return new JpaItemWriterBuilder<VoucherEntity>()
                .entityManagerFactory(entityManagerFactory)
                .build();
    }

    @Bean
    public Step expireVoucherStep(){
        return this.stepBuilderFactory
                .get("expireVoucherStep")
                .<VoucherEntity, VoucherEntity> chunk(chunk_size)
                .reader(expirePassesItemReader())
                .processor(expireVoucherItemProcessor())
                .writer(expireVoucherJpaItemWriter())
                .build();
    }
}
