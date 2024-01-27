package com.karma.voucher.model.voucher;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum VoucherStatus {
    NOT_PROGRESSED("미수강"), PROGRESSED("수강함"), EXPIRED("만료됨");
    private final String description;
}
