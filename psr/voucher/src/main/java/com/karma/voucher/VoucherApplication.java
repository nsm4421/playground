package com.karma.voucher;

import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@RequiredArgsConstructor
public class VoucherApplication {

    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;

    @Bean
    public Step voucherStep(){
        return stepBuilderFactory
                .get("voucherStep")
                .tasklet(new Tasklet() {
                    @Override
                    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                        System.out.println("Executed voucherStep method");
                        return RepeatStatus.FINISHED;
                    }
                })
                .build();
    }

    @Bean
    public Job voucherJob(){
        System.out.println("Executed voucherJob method");
        return jobBuilderFactory
                .get("voucherJob")
                .start(voucherStep())
                .build();
    }

    public static void main(String[] args) {
        SpringApplication.run(VoucherApplication.class, args);
    }
}
