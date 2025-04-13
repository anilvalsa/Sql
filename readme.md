# Spring Boot Interview Questions

## What is Spring Boot? Why use it over Spring?
Spring Boot is an extension of the Spring Framework that simplifies setting up and developing new Spring applications by:

- **Auto-Configuration**: Automatically configures Spring and third-party libraries.
- **Starter Dependencies**: Provides a set of dependency descriptors.
- **Embedded Servers**: Includes Tomcat, Jetty, or Undertow for quick deployment.
- **Production-Ready Features**: Metrics, health checks, externalized config.
- **Minimal Configuration**: Reduces boilerplate setup.

## What is Spring Framework?
Spring is a comprehensive framework for enterprise Java development. Key features include:

- Dependency Injection
- Aspect-Oriented Programming
- Transaction Management
- Data Access with JDBC/ORM
- MVC Framework
- Security
- Testing support

## Why not plain Spring?
While traditional Spring is flexible, Spring Boot improves productivity with less configuration and faster setup, ideal for rapid development.

## What is RAD and how does Spring Boot support it?
**RAD (Rapid Application Development)** is achieved in Spring Boot via:

- Convention over configuration
- Starter projects
- Embedded servers
- Spring Initializr

## Modules in Spring
- **Core Container**: Beans, Core, Context, SpEL
- **AOP**
- **Data Access/Integration**: JDBC, ORM, JMS, Transactions
- **Web**: Web, Web MVC, WebSocket
- **Security**
- **Testing**

## What is Dependency Injection (DI)?
A pattern for decoupling object creation. Advantages:

- Loose coupling
- Easier testing
- Code reuse
- Configuration flexibility

## What is Inversion of Control (IoC)?
IoC hands over control of object creation to the container. Benefits:

- Decoupling
- Easier testing
- Runtime configuration
- Centralized configuration

## What is a Spring Bean?
An object managed by the Spring container with features like:

- Lifecycle management
- Dependency management
- Scopes: Singleton, Prototype, etc.

## What are Inner Beans?
Defined inside another bean, anonymous, short-lived, and local to the parent bean.

## What is Bean Wiring?
Connecting beans via:

- XML Configuration
- Annotations (@Autowired, @Inject)
- Java Configuration (@Bean)

## Bean Scopes
- **Singleton** (default)
- **Prototype**
- **Request** (web)
- **Session** (web)
- **Application** (web)
- **WebSocket**

## Spring Configuration File Types
- **XML**: `<beans>`
- **Java**: `@Configuration` + `@Bean`
- **Annotation-Based**: `@Component`, `@Service`, etc.

## Autowiring in Spring
Modes:

- **no** (manual)
- **byName**
- **byType**
- **constructor**
- **autodetect** (deprecated)

## @Autowired vs @Inject
| Feature               | @Autowired (Spring)              | @Inject (Java EE)          |
|----------------------|----------------------------------|----------------------------|
| Library              | Spring                           | Javax                      |
| Optional Dependency  | `@Autowired(required=false)`     | Not supported              |

## @Component vs @Bean
| Feature          | @Component                 | @Bean                           |
|------------------|----------------------------|----------------------------------|
| Location         | Class-level                | Method-level in config class     |
| Scanning         | Component scanning         | Explicit declaration             |

## @Autowired Use Cases
```java
// Field Injection
@Autowired
private UserRepository userRepository;

// Constructor Injection
@Autowired
public UserService(UserRepository userRepository) {
    this.userRepository = userRepository;
}

// Setter Injection
@Autowired
public void setUserRepository(UserRepository userRepository) {
    this.userRepository = userRepository;
}
```

## @Qualifier Annotation
Used to disambiguate:
```java
@Autowired
@Qualifier("specificUserRepository")
private UserRepository userRepository;
```

## Constructor vs Setter Injection
| Feature           | Constructor                     | Setter                         |
|------------------|----------------------------------|---------------------------------|
| Mandatory         | Yes                              | No                              |
| Immutability      | Promoted                         | Mutable                         |
| Circular Dep.     | Risk exists                      | Safer                           |

## Stereotype Annotations
- `@Component`
- `@Service`
- `@Repository`
- `@Controller`

## IoC Container Types
- **BeanFactory**: Basic, lazy loading
- **ApplicationContext**: Advanced features (events, i18n, AOP)

## ApplicationContext Implementations
- `AnnotationConfigApplicationContext`
- `ClassPathXmlApplicationContext`
- `FileSystemXmlApplicationContext`
- `WebApplicationContext`

```java
ApplicationContext ctx = new AnnotationConfigApplicationContext(AppConfig.class);
MyService myService = ctx.getBean(MyService.class);
myService.doStuff();
```

## @Required Annotation
```java
@Required
public void setName(String name) {
   this.name = name;
}
```

## Lifecycle Methods
- `init` and `destroy` methods
- `@PostConstruct`, `@PreDestroy`
- Implement `InitializingBean`, `DisposableBean`

```java
@PostConstruct
public void init() {}

@PreDestroy
public void cleanup() {}
```

## Profiles in Spring
```java
@Profile("dev")
@Bean
public DataSource devDataSource() {...}

// Activate in properties
spring.profiles.active=dev
```

## Embedded Tomcat Configuration
- **Change Port**:
```properties
server.port=8081
```
- **Disable Web Server**:
```java
new SpringApplicationBuilder(MyApp.class).web(WebApplicationType.NONE).run(args);
```
```properties
spring.main.web-application-type=none
```

## Replace Embedded Tomcat
- Exclude from dependencies
- Add Jetty/Undertow dependency

## Disable Auto-Configuration
```java
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
```
```properties
spring.autoconfigure.exclude=org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration
```

## @SpringBootApplication Internals
- `@Configuration`
- `@EnableAutoConfiguration`
- `@ComponentScan`

## @RestController
```java
@RestController
@RequestMapping("/api")
public class UserController {
   @GetMapping("/users")
   public List<User> getUsers() {
       return userService.findAll();
   }
}
```

## @RestController vs @Controller
| Feature           | @RestController                | @Controller                   |
|------------------|---------------------------------|-------------------------------|
| Use              | REST APIs                       | Web pages (views)             |
| Returns          | JSON/XML                        | View pages                    |

## @RequestMapping vs @GetMapping
```java
@RequestMapping(value="/users", method=RequestMethod.GET)
```
```java
@GetMapping("/users")
```

## Spring Actuator
- Health checks
- Metrics
- Application info
- Management endpoints

```xml
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

## Reading application.properties
- **Using @Value**
```java
@Value("${my.property}")
private String myProperty;
```
- **Using Environment**
```java
@Autowired
private Environment environment;
String myProperty = environment.getProperty("my.property");
```

## Profiles in Spring Boot
- Use `@Profile`
- Activate using `spring.profiles.active`
- Environment-specific property files (e.g. `application-dev.properties`)