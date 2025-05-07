package com.karma.voucher.repository;

import com.karma.voucher.model.program.ProgramEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
public class ProgramRepositoryTest {
    @Autowired private ProgramRepository programRepository;

    @Test
    @DisplayName("[programRepository]업데이트 테스트")
    public void givenIdCountPeriod_whenUpdate_thenAssertUpdated(){
        Integer originalCount = 30;
        Integer originalPeriod = 40;
        Integer newCount = 50;
        Integer newPeriod = 60;

        ProgramEntity programEntity = new ProgramEntity();
        programEntity.setCount(originalCount);
        programEntity.setName("테스트코드에서 넣은 프로그램명");
        programEntity.setPeriod(originalPeriod);
        ProgramEntity SavedProgramEntity = programRepository.save(programEntity);
        Integer id = SavedProgramEntity.getId();

        programRepository.updateCountAndPeriodById(programEntity.getId(), newCount, newPeriod);
        ProgramEntity savedProgramEntity = programRepository.findById(id).orElseThrow(RuntimeException::new);

        assertEquals(newCount,savedProgramEntity.getCount());
        assertEquals(newPeriod,savedProgramEntity.getPeriod());
    }

    @Test
    @DisplayName("[programRepository]정상동작")
    public void givenEntity_whenSave_thenAssertNotNull(){
        ProgramEntity programEntity = new ProgramEntity();
        programEntity.setCount(10);
        programEntity.setName("테스트코드에서 넣은 프로그램명");
        programEntity.setPeriod(6);
        ProgramEntity programEntitySaved = programRepository.save(programEntity);
        assertNotNull(programEntitySaved.getId());
    }


}
