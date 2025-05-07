package com.karma.voucher.batch;

import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
public class DispenseVoucherConfig {
    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;
    private final DispenseVoucherTasklet dispenseVoucherTasklet;

    @Bean
    public Job dispenseVoucherJob(){
        return this.jobBuilderFactory
                .get("dispenseVoucherJob")
                .start(dispenseVoucherStep())
                .build();
    }

    @Bean
    public Step dispenseVoucherStep(){
        return this.stepBuilderFactory
                .get("dispenseVoucherStep")
                .tasklet(dispenseVoucherTasklet)
                .build();
    }
}
