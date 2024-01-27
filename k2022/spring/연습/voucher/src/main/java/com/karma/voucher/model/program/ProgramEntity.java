package com.karma.voucher.model.program;

import com.karma.voucher.model.AuditingFields;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Getter
@Setter
@ToString
@Entity
@Table(name="program")
public class ProgramEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column private String name;

    @Column private Integer count;

    @Column private Integer period;

    public static ProgramEntity of(String name, Integer count, Integer period){
        ProgramEntity programEntity = new ProgramEntity();
        programEntity.setPeriod(period);
        programEntity.setCount(count);
        programEntity.setName(name);
        return programEntity;
    }
}
