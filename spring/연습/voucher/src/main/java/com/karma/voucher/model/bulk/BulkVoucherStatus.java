package com.karma.voucher.model.bulk;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum BulkVoucherStatus {
    READY("준비됨"), COMPLETED("완료됨");
    private final String description;
}
