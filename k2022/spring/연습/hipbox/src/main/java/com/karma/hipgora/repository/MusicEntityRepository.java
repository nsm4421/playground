package com.karma.hipgora.repository;

import com.karma.hipgora.model.music.MusicEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MusicEntityRepository extends JpaRepository<MusicEntity, Long> {

}
