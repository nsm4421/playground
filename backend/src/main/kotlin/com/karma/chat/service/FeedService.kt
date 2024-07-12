package com.karma.chat.service

import com.karma.chat.domain.feed.Feed
import com.karma.chat.repository.FeedRepository
import jakarta.persistence.EntityNotFoundException
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service

@Service
class FeedService (
    val feedRepository: FeedRepository
){
    fun createFeed(content:String, media:List<String>):Long
    = feedRepository.save(Feed(content=content, media=media)).id

    fun modifyFeed(feedId:Long, content:String, media:List<String>, username:String):Long{
        val feed = feedRepository.findByIdOrNull(feedId)
            ?:throw EntityNotFoundException()
        if (feed.createdBy != username){
            throw IllegalAccessException("username not matched")
        }
        feed.content = content
        feed.media = media
        return feedRepository.save(feed).id
    }

    fun deleteFeed(feedId:Long, username:String){
        val feed = feedRepository.findByIdOrNull(feedId)
            ?:throw EntityNotFoundException()
        if (feed.createdBy != username){
            throw IllegalAccessException("username not matched")
        }
        return feedRepository.deleteById(feedId)
    }
}