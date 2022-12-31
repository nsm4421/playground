package com.karma.voucher.batch;

import com.karma.voucher.model.bulk.BulkVoucherEntity;
import com.karma.voucher.model.bulk.BulkVoucherStatus;
import com.karma.voucher.model.user.UserGroupMappingEntity;
import com.karma.voucher.model.voucher.BulkVoucherEntityToVoucherEntityMapper;
import com.karma.voucher.model.voucher.VoucherEntity;
import com.karma.voucher.repository.BulkVoucherRepository;
import com.karma.voucher.repository.UserGroupMappingRepository;
import com.karma.voucher.repository.VoucherRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class DispenseVoucherTasklet implements Tasklet {
    private final VoucherRepository voucherRepository;
    private final BulkVoucherRepository bulkVoucherRepository;
    private final UserGroupMappingRepository userGroupMappingRepository;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        final LocalDateTime startAt = LocalDateTime.now().minusDays(1);
        final List<BulkVoucherEntity> bulkVoucherEntities = bulkVoucherRepository
                .findByStatusAndStartAtGreaterThan(BulkVoucherStatus.READY, startAt);
        for (BulkVoucherEntity bulkVoucherEntity:bulkVoucherEntities){
            final List<String> userIds = userGroupMappingRepository
                    .findByUserGroupId(bulkVoucherEntity.getUserGroupId())
                    .stream()
                    .map(UserGroupMappingEntity::getUserId)
                    .collect(Collectors.toList());
            bulkVoucherEntity.setStatus(BulkVoucherStatus.COMPLETED);
        }
        return RepeatStatus.FINISHED;
    }

    /*
        BulkVoucherEntity 로부터 생성한 VoucherEntity List 를 저장, 개수 반환
    */
    private int dispenseVoucher(BulkVoucherEntity bulkVoucherEntity, List<String> userIds){
        List<VoucherEntity> voucherEntities = new ArrayList<VoucherEntity>();
        for (String userId:userIds){
            VoucherEntity voucherEntity = BulkVoucherEntityToVoucherEntityMapper.INSTANCE.convert(bulkVoucherEntity, userId);
            voucherEntities.add(voucherEntity);
        }
        return voucherRepository.saveAll(voucherEntities).size();
    }
}
