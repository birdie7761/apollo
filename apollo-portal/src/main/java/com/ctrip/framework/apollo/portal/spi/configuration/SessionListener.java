package com.ctrip.framework.apollo.portal.spi.configuration;

import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSessionEvent;

/**
 * Created by wur on 2017/11/28.
 */
@Component
public class SessionListener extends HttpSessionEventPublisher {
    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        System.out.println("==== Session is created ====");
        httpSessionEvent.getSession().setMaxInactiveInterval(8*60*60);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {

    }
}
