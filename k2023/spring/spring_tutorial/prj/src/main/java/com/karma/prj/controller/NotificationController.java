package com.karma.prj.controller;

import com.karma.prj.controller.response.GetNotificationResponse;
import com.karma.prj.model.entity.UserEntity;
import com.karma.prj.model.util.CustomResponse;
import com.karma.prj.service.NotificationService;
import com.karma.prj.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Controller
@RequestMapping("api/v1/notification")
@RequiredArgsConstructor
public class NotificationController {
    private final UserService userService;
    private final NotificationService notificationService;

    @GetMapping("/notification/connect")
    public SseEmitter connectNotification(Authentication authentication){
        return notificationService.connectNotification(((UserEntity) authentication.getPrincipal()).getId());
    }

    /**
     * 알람 가져오기
     * @param authentication 인증 context
     * @param pageable 페이지
     * @return GetNotificationResponse Page
     */
    @GetMapping("/notification")
    public CustomResponse<Page<GetNotificationResponse>> getNotification(
            Authentication authentication,
            @PageableDefault Pageable pageable
    ){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return CustomResponse.success(notificationService.getNotification(user.getId(), pageable).map(GetNotificationResponse::from));
    }

    /**
     * 알림 삭제하기
     * @param authentication 인증 context
     * @param notificationId 삭제할 알림 id
     * @return 삭제한 알림 id
     */
    @DeleteMapping("/notification/{notificationId}")
    public CustomResponse<Void> deleteNotification(
            Authentication authentication,
            @PathVariable Long notificationId
    ){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        notificationService.deleteNotificationById(user.getId(), notificationId);
        return CustomResponse.success();
    }

    /**
     * 알림 전체 삭제하기
     * @param authentication 인증 context
     * @return 삭제한 알림 id
     */
    @DeleteMapping("/notification")
    public CustomResponse<Void> deleteAllNotification(
            Authentication authentication
    ){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        notificationService.deleteAllNotification(user.getId());
        return CustomResponse.success();
    }
}
