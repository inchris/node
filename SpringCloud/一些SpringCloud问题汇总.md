## application.yml 和 bootstrap.yml 有何区别？

https://stackoverflow.com/questions/32997352/what-is-the-diference-between-putting-a-property-on-application-yml-or-bootstrap?answertab=votes#tab-top

> I have just asked the `Spring Cloud` guys and thought I should share the info I have here.

> ** `bootstrap.yml` is loaded before `application.yml`. **

> It is typically used for the following:

> when using Spring Cloud Config Server, you should specify `spring.application.name` and `spring.cloud.config.server.git.uri` inside `bootstrap.yml`
> some `encryption/decryption` information

> Technically, `bootstrap.yml` is loaded by a parent Spring `ApplicationContext`. That parent `ApplicationContext` is loaded before the one that uses `application.yml`.

## Spring Eureka服务器在客户端url中找不到 Context-path

https://stackoverflow.com/questions/35835348/spring-eureka-server-does-not-find-context-path-in-client-url?answertab=votes#tab-top

> If your Eureka client is setup via Spring's `@EnableEurekaClient`, then the client will default the health check and status check to `/health` and `/info` respectively.  (These paths may be the default values beyond the Spring `@EnableEurekaClient` setup, but I am unfamiliar with those at this point in time).

> You can override these defaults by setting the following properties:

> > eureka.instance.statusPageUrlPath

> > eureka.instance.healthCheckUrlPath

> The [Spring Cloud Documentation](http://cloud.spring.io/spring-cloud-static/docs/1.0.x/spring-cloud.html#_status_page_and_health_indicator) contains this information, plus much more.

## 在eureka环境下如何正确设置spring boot admin客户端的 management.context-path

https://stackoverflow.com/questions/40504955/how-to-correctly-set-management-context-path-for-spring-boot-admin-client-under?answertab=votes#tab-top

> On the client:
```
eureka:
  instance:
    metadata-map:
      management.context-path: ${management.context-path}
```
> As described in the [docs](http://codecentric.github.io/spring-boot-admin/1.4.3/#_serviceinstanceconverter):

> > If you want to customize the default conversion of services you can either add health.path, management.port and/or mangament.context-path entries to the services metadata.
