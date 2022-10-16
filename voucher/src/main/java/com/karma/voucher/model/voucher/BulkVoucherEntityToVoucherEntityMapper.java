package com.karma.voucher.model.voucher;

import com.karma.voucher.model.bulk.BulkVoucherEntity;
import com.karma.voucher.model.bulk.BulkVoucherStatus;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)  // 일치하지 않는 필드 무시
public interface BulkVoucherEntityToVoucherEntityMapper {
    BulkVoucherEntityToVoucherEntityMapper INSTANCE = Mappers.getMapper(BulkVoucherEntityToVoucherEntityMapper.class);
    /*
    BulkVoucher
        Integer id;
        Integer programId;
        String userGroupId;
        BulkVoucherStatus status;
        LocalDateTime startAt;
        LocalDateTime endAt;
        Integer count;

    Voucher
        Integer id;
        Integer programId;
        String userId;
        VoucherStatus status
        Integer remainingCount;
        LocalDateTime startAt;
        LocalDateTime endAt;
        LocalDateTime expiredAt;
 */
    @Mapping(target="status", qualifiedByName = "defaultStatus")
    @Mapping(target="remainingCount", source = "bulkVoucherEntity.count")
    VoucherEntity convert(BulkVoucherEntity bulkVoucherEntity, String userId);

    @Named("defaultStatus")
    default VoucherStatus status(BulkVoucherStatus status){
        return VoucherStatus.NOT_PROGRESSED;
    }
}
