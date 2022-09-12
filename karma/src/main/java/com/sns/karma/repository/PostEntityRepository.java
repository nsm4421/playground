package com.sns.karma.repository;

import com.sns.karma.model.post.PostEntity;;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostEntityRepository extends JpaRepository<PostEntity, Long> {

}
