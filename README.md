# sdd-database-desing

## Project: SDD-Catalog

Currently, video game enthusiasts, particularly players of [**Need for Speed Unbound**](https://www.ea.com/es-es/games/need-for-speed/need-for-speed-unbound), lack a centralized platform where they can create, save, and share personalized configurations for their vehicles. This includes specific features such as the engine, suspension, wheels, and other modifications that are part of their game strategies.

Players often rely on unorganized notes or screenshots, making it challenging to manage and share ideas with other users.

---

## Proposed Solution

We propose developing a web application called [**SDD-Catalog**](https://sdd-catalog.netlify.app/home), which will allow users to:

### 1. Manage Vehicle Configurations  
Users will be able to create, save, and update configurations for their vehicles, defining technical aspects like the engine, suspension, turbo, and more. These configurations will be accessible for consultation at any time.

### 2. Explore Other Users' Configurations  
A gallery will be available where users can browse and explore configurations shared by other players, fostering collaborative learning and inspiration.

### 3. Authentication and Security  
Users will have personal accounts secured with robust authentication to ensure only they can manage their configurations.

### 4. User Interaction  
The platform will include a feature to contact the administrator and eventually communicate with other users, fostering a collaborative community.

---

## Main Objective 

Provide a practical, accessible, and secure tool that facilitates the creation, management, and collaboration among [**Need for Speed Unbound**](https://www.ea.com/es-es/games/need-for-speed/need-for-speed-unbound) players, enhancing the gaming experience and fostering an active community.


## Summary

- [Introduction](#introduction)
- [Database Type](#database-type)
- [Table Structure](#table-structure)
    - [modules](#modules)
    - [operations](#operations)
    - [roles](#roles)
    - [granted_permissions](#granted_permissions)
    - [users](#users)
    - [jwt_registers](#jwt_registers)
    - [init_skids](#init_skids)
    - [street_types](#street_types)
    - [classes](#classes)
    - [turbo_types](#turbo_types)
    - [makers](#makers)
    - [levels](#levels)
    - [cars](#cars)
    - [drivers](#drivers)
    - [tires](#tires)
    - [suspensions](#suspensions)
    - [turbos](#turbos)
    - [gears](#gears)
    - [engines](#engines)
    - [auxiliaries](#auxiliaries)
    - [car_configurations](#car_configurations)
    - [user_car_configurations](#user_car_configurations)
    - [user_car_favorites](#user_car_favorites)
- [Relationships](#relationships)
- [Database Diagram](#database-Diagram)

## Introduction

The database for [**SDD-Catalog**](https://sdd-catalog.netlify.app/home) has been designed to efficiently address key aspects of the application, including security, vehicle configuration management, and user interaction. The design focuses on three main areas:

1. **User Authentication and Management Security:**  
   A robust system has been implemented to store and manage user information, ensuring that only authenticated users can access their configurations and data. Password security is handled through encryption techniques and token-based authentication, protecting sensitive data privacy.

2. **Vehicle Configuration Storage:**  
   The database allows storing personalized vehicle configurations, including attributes such as engine, suspension, turbo, and other key details for each vehicle. Each configuration is linked to a user, and can be saved, modified, or deleted as needed.

3. **User and Admin Interaction:**  
   In addition to storing configurations, the database supports user and admin interaction on the platform. This includes tracking messages sent by users and managing requests and inquiries.

The database design is focused on scalability, allowing for the addition of more features and functionalities in the future without compromising performance or security.


---

## Database type

- **Database system:** PostgreSQL
## Table structure

### modules

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **module** | VARCHAR(50) | not null  |  | |
| **base_path** | VARCHAR(50) | not null  |  | | 

#### **Purpose**:
The `modules` table is designed to store information about different application modules, each of which corresponds to a group of related endpoints. The table helps in organizing and structuring the API endpoints by associating each with a specific base path, making it easier to manage and maintain the routing of requests.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each module (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.
  
- **module**: 
  - **Type**: VARCHAR(50)
  - **Description**: The name of the module (e.g., `user`, `product`, `auth`).
  - **Constraints**: Not null.
  
- **base_path**: 
  - **Type**: VARCHAR(50)
  - **Description**: The base path of the module, used as a prefix for all endpoints within that module (e.g., `/api/users`, `/api/products`).
  - **Constraints**: Not null.

#### **References**:
- No external references (foreign keys) in this table.

#### **Notes**:
This table plays a crucial role in organizing the API by categorizing it into different modules. Each module corresponds to a specific functionality within the application, and the base path defines the route prefix for all the endpoints under that module. This design allows for easier scalability and management of API routes as the application grows.

---

### operations

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement | operations_id_fk | |
| **name** | VARCHAR(50) | not null  |  | |
| **path** | VARCHAR(50) | not null  |  | |
| **http_method** | VARCHAR(10) | not null  |  | |
| **permit_all** | TINYINT | not null , default: 0 |  | |
| **module_id** | INTEGER | not null  | operations_module_id_fk | | 

### **operations Table**

#### **Purpose**:
The `operations` table is designed to store information about the different operations (or actions) within the application's API. Each operation represents a specific endpoint with its associated HTTP method and path. The table also tracks whether the operation is publicly accessible (`permit_all`) and associates each operation with a module.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each operation (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.
  - **References**: Foreign key linking to the `operations_id_fk`.

- **name**: 
  - **Type**: VARCHAR(50)
  - **Description**: The name of the operation (e.g., `createUser`, `getProduct`).
  - **Constraints**: Not null.
  
- **path**: 
  - **Type**: VARCHAR(50)
  - **Description**: The path for the operation, defining the endpoint's URL (e.g., `/api/users`, `/api/products`).
  - **Constraints**: Not null.

- **http_method**: 
  - **Type**: VARCHAR(10)
  - **Description**: The HTTP method associated with the operation (e.g., `GET`, `POST`, `PUT`, `DELETE`).
  - **Constraints**: Not null.
  
- **permit_all**: 
  - **Type**: TINYINT
  - **Description**: Indicates whether the operation is publicly accessible (1 for yes, 0 for no). This helps determine whether authentication is required for accessing the operation.
  - **Constraints**: Not null, default: 0.
  
- **module_id**: 
  - **Type**: INTEGER
  - **Description**: The identifier of the module to which the operation belongs.
  - **Constraints**: Not null.
  - **References**: Foreign key linking to `operations_module_id_fk`.

#### **References**:
- **operations_id_fk**: Foreign key referencing another table (e.g., to define related operations).
- **operations_module_id_fk**: Foreign key linking to the `modules` table, indicating which module the operation belongs to.

#### **Notes**:
This table allows for the organization of operations in the API by associating each operation with a module and an HTTP method. The `permit_all` field enables fine-grained control over which operations require authentication. The structure of this table helps in managing access control, routing, and API documentation.

---

### roles

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **name** | VARCHAR(30) | not null  |  | | 

### **roles Table**

#### **Purpose**:
The `roles` table is used to define the different roles within the application. Each role represents a set of permissions or privileges that can be assigned to users, helping to manage access control in the system.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each role (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.
  
- **name**: 
  - **Type**: VARCHAR(30)
  - **Description**: The name of the role (e.g., `admin`, `user`, `moderator`).
  - **Constraints**: Not null.
  
#### **Notes**:
The `roles` table is essential for implementing role-based access control (RBAC) in the application. Each role is associated with specific permissions, and these roles can be assigned to users, enabling the system to restrict or allow access to various features based on the user's role.

---

### granted_permissions

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **role_id** | INTEGER | not null  | granted_permissions_role_id_fk | |
| **operation_id** | INTEGER | not null  |  | | 

### **granted_permissions Table**

#### **Purpose**:
The `granted_permissions` table is used to store the associations between roles and operations (permissions). It tracks which roles are granted specific permissions (operations) within the system, enabling role-based access control (RBAC) to determine which users can perform certain actions.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each record (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.
  
- **role_id**: 
  - **Type**: INTEGER
  - **Description**: A reference to the `roles` table that indicates which role is granted the permission.
  - **Constraints**: Not null, foreign key to `roles` table.
  
- **operation_id**: 
  - **Type**: INTEGER
  - **Description**: A reference to the `operations` table that indicates which operation (permission) is granted to the role.
  - **Constraints**: Not null, foreign key to `operations` table.

#### **Notes**:
The `granted_permissions` table forms a many-to-many relationship between the `roles` and `operations` tables. It allows for the dynamic assignment of permissions to roles, ensuring that users with specific roles can perform the operations associated with them.

---

### users

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **name** | VARCHAR(50) | not null  |  | |
| **username** | VARCHAR(50) | not null , unique |  | |
| **password** | VARCHAR(128) | not null  |  | |
| **email** | VARCHAR(255) | not null , unique |  | |
| **role_id** | INTEGER | not null  | users_role_id_fk | |
| **account_non_expired** | TINYINT | not null , default: 1 |  | |
| **account_non_locked** | TINYINT | not null , default: 1 |  | |
| **credentials_non_expired** | TINYINT | not null , default: 1 |  | |
| **enabled** | TINYINT | not null , default: 1 |  | |
| **color_profile** | VARCHAR(7) | not null  |  | |
| **is_email_valid** | TINYINT | not null , default: 0 |  | | 

### **users Table**

#### **Purpose**:
The `users` table stores information about the users in the system, including their personal details, credentials, and role assignments. It manages user authentication and authorization through fields such as password, role, and account status. The table also supports additional user profile information, like their color preference for UI customization.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each user (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **name**: 
  - **Type**: VARCHAR(50)
  - **Description**: The full name of the user.
  - **Constraints**: Not null.

- **username**: 
  - **Type**: VARCHAR(50)
  - **Description**: The username used by the user to log in. Must be unique.
  - **Constraints**: Not null, unique.

- **password**: 
  - **Type**: VARCHAR(128)
  - **Description**: The user's password (hashed and stored for security).
  - **Constraints**: Not null.

- **email**: 
  - **Type**: VARCHAR(255)
  - **Description**: The user's email address. Used for communication and account recovery. Must be unique.
  - **Constraints**: Not null, unique.

- **role_id**: 
  - **Type**: INTEGER
  - **Description**: A reference to the user's assigned role (e.g., admin, user). Defines the level of access and permissions.
  - **Constraints**: Not null, foreign key to `roles` table.

- **account_non_expired**: 
  - **Type**: TINYINT
  - **Description**: A flag indicating whether the user's account is expired. A value of `1` means the account is active.
  - **Constraints**: Not null, default: `1`.

- **account_non_locked**: 
  - **Type**: TINYINT
  - **Description**: A flag indicating whether the user's account is locked. A value of `1` means the account is not locked.
  - **Constraints**: Not null, default: `1`.

- **credentials_non_expired**: 
  - **Type**: TINYINT
  - **Description**: A flag indicating whether the user's credentials (password) are expired. A value of `1` means the credentials are valid.
  - **Constraints**: Not null, default: `1`.

- **enabled**: 
  - **Type**: TINYINT
  - **Description**: A flag indicating whether the user's account is enabled. A value of `1` means the account is active and enabled.
  - **Constraints**: Not null, default: `1`.

- **color_profile**: 
  - **Type**: VARCHAR(7)
  - **Description**: A color code for the user's UI theme or customization.
  - **Constraints**: Not null.

- **is_email_valid**: 
  - **Type**: TINYINT
  - **Description**: A flag indicating whether the user's email address has been validated. A value of `1` means the email is valid.
  - **Constraints**: Not null, default: `0`.

#### **Notes**:
The `users` table is crucial for managing user authentication and profile details. It supports role-based access control (RBAC), where the `role_id` field defines the user's permissions within the system. Fields like `enabled`, `account_non_locked`, and `account_non_expired` help manage account security, while `is_email_valid` ensures the email address has been confirmed by the user.

---

### jwt_registers

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **user_id** | INTEGER | not null  | jwt_registers_user_id_fk | |
| **token_jwt** | VARCHAR(2048) | not null  |  | |
| **expiration** | DATETIME | not null  |  | |
| **enable** | TINYINT | not null  |  | |
| **reference_site** | VARCHAR(255) | not null  |  | | 

### **jwt_registers Table**

#### **Purpose**:
The `jwt_registers` table stores information about JSON Web Tokens (JWT) issued to users for authentication. It includes the JWT itself, the associated user, its expiration date, the token status (enabled/disabled), and the reference to the site or application from which the token was issued. This table helps manage user sessions and ensures proper token expiration and validation.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each token record (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **user_id**: 
  - **Type**: INTEGER
  - **Description**: A reference to the user associated with the token. Links to the `users` table.
  - **Constraints**: Not null, foreign key to `users` table.

- **token_jwt**: 
  - **Type**: VARCHAR(2048)
  - **Description**: The actual JWT string used for user authentication.
  - **Constraints**: Not null.

- **expiration**: 
  - **Type**: DATETIME
  - **Description**: The expiration date and time of the JWT. This field ensures that the token will not be valid beyond this time.
  - **Constraints**: Not null.

- **enable**: 
  - **Type**: TINYINT
  - **Description**: A flag indicating whether the JWT is enabled or disabled. A value of `1` means the token is active, and `0` means it is disabled.
  - **Constraints**: Not null.

- **reference_site**: 
  - **Type**: VARCHAR(255)
  - **Description**: A reference to the site or application where the token was issued. This can help to track the origin of the token.
  - **Constraints**: Not null.

#### **Notes**:
The `jwt_registers` table plays a critical role in managing user authentication tokens. It helps track active sessions, the validity of tokens, and their expiration. By storing the `reference_site`, the system can distinguish where each token was generated, supporting multi-platform applications.

---

### init_skids

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **skid_type** | VARCHAR(45) | not null  |  | | 

### **init_skids Table**

#### **Purpose**:
The `init_skids` table is designed to store different types of skidding behaviors for vehicles. It allows the system to categorize various drifting or skidding types that can be applied to vehicles in the game, helping players define and manage their driving styles or vehicle configurations in more detail.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each skidding behavior record (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **skid_type**: 
  - **Type**: VARCHAR(45)
  - **Description**: The name or type of the skidding behavior (e.g., "drift", "burnout", "e-brake", etc.). This field helps categorize different driving techniques or skidding modes available in the game.
  - **Constraints**: Not null.

#### **Notes**:
The `init_skids` table provides a structured way to define and manage the various types of skidding behaviors in the system, allowing for better categorization of vehicle configurations and enhancing the overall gaming experience. By linking these skid types to vehicle settings, players can fine-tune their car setups according to their preferred skidding styles.

---

### street_types

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **street_type** | VARCHAR(45) | not null  |  | | 

### **street_types Table**

#### **Purpose**:
The `street_types` table is used to store different types of street tires that can be used by vehicles in the game. These tire types define the characteristics and handling attributes that players can apply to their vehicles, affecting performance based on terrain or road conditions.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each tire type record (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **street_type**: 
  - **Type**: VARCHAR(45)
  - **Description**: The name or category of the street tire (e.g., "performance", "off-road", "racing", etc.). This field categorizes the different types of tires available in the game, each affecting handling and performance differently.
  - **Constraints**: Not null.

#### **Notes**:
The `street_types` table plays a vital role in defining the tire options available for vehicles, helping players customize their cars for different terrains and racing conditions. Each tire type can have specific performance advantages depending on the game's mechanics, enhancing the overall gaming experience.

---

### classes

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **name** | VARCHAR(2) | not null  |  | | 

### **classes Table**

#### **Purpose**:
The `classes` table stores the different categories or classes of vehicles in the game, which are used to group cars based on their performance and specifications. These classes help define the type of car, such as whether it is a sports car, muscle car, or other types, and determine which other cars it competes with in races.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each vehicle class record (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **name**: 
  - **Type**: VARCHAR(2)
  - **Description**: A short code or name for the vehicle class (e.g., "A", "B", "S"). This field categorizes the different vehicle classes based on their performance tier in the game.
  - **Constraints**: Not null.

#### **Notes**:
The `classes` table is critical in organizing and differentiating vehicle types in the game, allowing players to choose and compete with vehicles that are categorized according to their power and performance. It enhances the competitive balance by ensuring that vehicles within the same class compete on an equal footing.

---

### turbo_types

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **type** | VARCHAR(30) | not null  |  | | 

### **turbo_types Table**

#### **Purpose**:
The `turbo_types` table stores the different types of induction systems (turbos) available for vehicles in the game. These systems enhance the performance of the engine by forcing more air into the combustion chamber, ultimately increasing the engine’s power output. Each record in this table represents a unique turbo system type that can be applied to vehicles in the game.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each turbo type record (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **type**: 
  - **Type**: VARCHAR(30)
  - **Description**: The name of the turbo induction system (e.g., "Single Turbo", "Twin Turbo"). This field categorizes the different turbo systems available for the vehicles.
  - **Constraints**: Not null.

#### **Notes**:
The `turbo_types` table is essential for customizing vehicles in the game. It provides the different turbo systems that players can choose from to enhance their vehicle’s performance. By selecting the right turbo type, players can fine-tune their cars for better speed, handling, and overall performance in races.

---

### makers

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **name** | VARCHAR(45) | not null  |  | | 

### **makers Table**

#### **Purpose**:
The `makers` table stores information about the manufacturers of vehicles in the game. This includes the names of car brands or companies that produce different vehicle models. Each record in this table represents a unique manufacturer.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each manufacturer (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **name**: 
  - **Type**: VARCHAR(45)
  - **Description**: The name of the vehicle manufacturer (e.g., "Ferrari", "Toyota"). This field stores the name of the car brand or company.
  - **Constraints**: Not null.

#### **Notes**:
The `makers` table is vital for linking vehicles to their respective manufacturers. Players can filter, sort, and explore different cars based on the manufacturer, allowing for more personalized and detailed car selections.

---

### levels

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **level** | VARCHAR(10) | not null  |  | | 

### **levels Table**

#### **Purpose**:
The `levels` table stores information about the different levels or tiers of vehicle parts in the game. These levels define the quality or performance of specific car components (such as engines, suspensions, etc.) and may affect their overall attributes or stats in the game. The levels available are: Basic, Sports, Pro, Super, and Elite.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER 
  - **Description**: A unique identifier for each level (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **level**: 
  - **Type**: VARCHAR(10)
  - **Description**: The name or identifier of the level (e.g., "Basic", "Sports", "Pro", "Super", "Elite"). This field indicates the performance tier or rank of a part.
  - **Constraints**: Not null.

#### **Notes**:
The `levels` table helps categorize and identify different performance levels for various car components. This classification allows players to customize their vehicles according to their preferences for performance, enhancing their gameplay strategy.

---

### cars

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **maker_id** | INTEGER | not null  | cars_maker_id_fk | |
| **model** | VARCHAR(50) | not null  |  | |
| **car_year** | VARCHAR(4) | not null  |  | | 

### **cars Table**

#### **Purpose**:
The `cars` table stores information about the vehicles in the game. Each record represents a unique car, identified by its model, manufacturer, and year. This table helps organize car configurations, allowing users to associate their custom vehicle setups with specific cars.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each car (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **maker_id**: 
  - **Type**: INTEGER
  - **Description**: The ID of the car's manufacturer, linking the car to a specific maker from the `makers` table.
  - **Constraints**: Not null.
  - **References**: `makers.id` (Foreign Key).

- **model**: 
  - **Type**: VARCHAR(50)
  - **Description**: The model name of the car (e.g., "Mustang", "Civic").
  - **Constraints**: Not null.

- **car_year**: 
  - **Type**: VARCHAR(4)
  - **Description**: The year of manufacture of the car (e.g., "2020").
  - **Constraints**: Not null.

#### **Notes**:
The `cars` table helps track different car models and their respective manufacturers, which can then be used to create and store configurations of the vehicle in the platform.

---

### drivers

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **drive** | INTEGER | not null  |  | |
| **direction** | INTEGER | not null  |  | |
| **dawn_force** | INTEGER | not null  |  | |
| **control_traction** | TINYINT | not null , default: 0 |  | |
| **init_skid_id** | INTEGER | not null  | drivers_init_skid_id_fk | | 

### **drivers Table**

#### **Purpose**:
The `drivers` table stores information about the driving configuration for each car, such as the type of drive, direction, aerodynamic force, and traction control settings. This table also links to the `init_skid` table to indicate the type of skid behavior (drift or grip) associated with the car's driving style.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each driver configuration (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **drive**: 
  - **Type**: INTEGER
  - **Description**: The type of driving (e.g., 1 for rear-wheel drive, 2 for all-wheel drive). This field determines how the car handles its acceleration and power distribution.
  - **Constraints**: Not null.

- **direction**: 
  - **Type**: INTEGER
  - **Description**: The steering sensitivity or angle adjustment for the car's handling. Higher values indicate a greater turning response.
  - **Constraints**: Not null.

- **dawn_force**: 
  - **Type**: INTEGER
  - **Description**: The aerodynamic force applied to the car. This helps control stability and grip, especially at higher speeds. Larger values indicate stronger downforce for better handling.
  - **Constraints**: Not null.

- **control_traction**: 
  - **Type**: TINYINT
  - **Description**: A flag that indicates whether traction control is enabled for the car. `0` means traction control is off, and `1` means it is on. This helps to prevent wheel spin during acceleration.
  - **Constraints**: Not null, default: 0.

- **init_skid_id**: 
  - **Type**: INTEGER
  - **Description**: The ID of the type of skid behavior (drift or grip) that is applied to the car’s driving. This links to the `init_skid` table.
  - **Constraints**: Not null.
  - **References**: `init_skids.id` (Foreign Key).

#### **Notes**:
The `drivers` table helps define how a car behaves on the road, including its drive type, handling characteristics, and whether traction control is active. It also links to the `init_skid` table to determine whether the car is set up for drifting or grip-based driving.

---

### tires

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **street_type_id** | INTEGER | not null  | tires_street_type_id_fk | |
| **level_id** | INTEGER | not null  | tires_level_id_fk | | 

### **tires Table**

#### **Purpose**:
The `tires` table stores information about the types of tires used in the game, including the street type (e.g., road, off-road) and the level of performance (e.g., basic, pro, elite) for each tire. It links to the `street_types` and `levels` tables to define the characteristics of each tire in terms of road type and performance level.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each tire entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **street_type_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the tire to its street type, indicating whether the tire is for road, off-road, or another terrain type.
  - **Constraints**: Not null.
  - **References**: `street_types.id` (Foreign Key).

- **level_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the tire to its performance level, such as basic, pro, super, etc.
  - **Constraints**: Not null.
  - **References**: `levels.id` (Foreign Key).

#### **Notes**:
The `tires` table allows the game to categorize tires based on the type of terrain they are designed for and their performance level. Each tire entry is linked to specific street types and performance levels to define the car's handling characteristics.

---

### suspensions

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **street_type_id** | INTEGER | not null  | suspensions_street_type_id_fk | |
| **level_id** | INTEGER | not null  | suspensions_level_id_fk | | 

### **suspensions Table**

#### **Purpose**:
The `suspensions` table stores information about the types of suspension systems used in the game, categorized by street type (e.g., road, off-road) and performance level (e.g., basic, pro, elite). It links to the `street_types` and `levels` tables to define the characteristics of each suspension system based on the terrain type and performance level.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each suspension entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **street_type_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the suspension to its street type, indicating whether the suspension is for road, off-road, or another terrain type.
  - **Constraints**: Not null.
  - **References**: `street_types.id` (Foreign Key).

- **level_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the suspension to its performance level, such as basic, pro, super, etc.
  - **Constraints**: Not null.
  - **References**: `levels.id` (Foreign Key).

#### **Notes**:
The `suspensions` table allows the game to categorize suspension systems based on the type of terrain they are designed for and their performance level. Each suspension entry is linked to specific street types and performance levels to define how the car handles on different surfaces.

---

### turbos

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **turbo_type_id** | INTEGER | not null  | turbos_turbo_type_id_fk | |
| **level_id** | INTEGER | not null  | turbos_level_id_fk | | 

### **turbos Table**

#### **Purpose**:
The `turbos` table stores information about the different turbochargers used in the game, categorized by turbo type and performance level. It links to the `turbo_types` and `levels` tables to define the characteristics of each turbo system based on its type and level of performance.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each turbo entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **turbo_type_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the turbo to its specific type (e.g., single, twin-turbo).
  - **Constraints**: Not null.
  - **References**: `turbo_types.id` (Foreign Key).

- **level_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the turbo to its performance level, such as basic, pro, super, etc.
  - **Constraints**: Not null.
  - **References**: `levels.id` (Foreign Key).

#### **Notes**:
The `turbos` table allows the game to categorize turbochargers based on their type (e.g., single or twin-turbo) and their performance level. Each turbo entry is linked to specific turbo types and performance levels, which determine how the turbocharger affects the vehicle's overall performance.

---

### gears

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **gear_value** | INTEGER | not null  |  | |
| **level_id** | INTEGER | not null  | gears_level_id_fk | | 

### **gears Table**

#### **Purpose**:
The `gears` table stores information about the gears used by cars in the game, along with the corresponding performance level. This table defines the gear values for cars, linked to specific levels that determine the gear settings for each vehicle.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each gear entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **gear_value**: 
  - **Type**: INTEGER
  - **Description**: The gear value associated with the car's transmission system. This could represent a specific gear setting or ratio used by the vehicle.
  - **Constraints**: Not null.

- **level_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the gear to its performance level, such as basic, pro, super, etc.
  - **Constraints**: Not null.
  - **References**: `levels.id` (Foreign Key).

#### **Notes**:
The `gears` table allows the game to store gear settings for each car, categorized by performance level. Each gear entry is linked to a specific level, which defines how the gears affect the car's performance.

---

### engines

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **bhp** | INTEGER | not null  |  | |
| **liters** | DECIMAL | not null  |  | |
| **model** | VARCHAR(30) | not null  |  | |
| **level_id** | INTEGER | not null  | engines_level_id_fk | | 

### **engines Table**

#### **Purpose**:
The `engines` table stores the available engine configurations for cars in the game. This includes the engine's horsepower, displacement (liters), model, and the corresponding performance level, which defines the engine's capabilities.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each engine entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **bhp**: 
  - **Type**: INTEGER
  - **Description**: The horsepower of the engine. This value represents the engine's power output.
  - **Constraints**: Not null.

- **liters**: 
  - **Type**: DECIMAL
  - **Description**: The displacement of the engine in liters. This represents the size of the engine in terms of volume.
  - **Constraints**: Not null.

- **model**: 
  - **Type**: VARCHAR(30)
  - **Description**: The model or name of the engine, identifying the specific configuration of the engine.
  - **Constraints**: Not null.

- **level_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the engine to its performance level, such as basic, pro, super, etc.
  - **Constraints**: Not null.
  - **References**: `levels.id` (Foreign Key).

#### **Notes**:
The `engines` table is crucial for storing engine configurations that cars can use. Each engine entry has an associated level, indicating its performance tier. The engine's horsepower and displacement help determine its impact on the car's overall performance.

---

### auxiliaries

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **auxiliar** | VARCHAR(50) | not null  |  | |
| **level_id** | INTEGER | not null  | auxiliaries_level_id_fk | | 

### **auxiliaries Table**

#### **Purpose**:
The `auxiliaries` table stores additional enhancements or boosts that can be applied to the cars, such as nitro boosts for drifting or rubbing, increased car damage, reduced impact, and other performance-related features. These auxiliaries enhance the car's abilities during gameplay.

#### **Fields**:
- **id**: 
  - **Type**: INTEGER
  - **Description**: A unique identifier for each auxiliary entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **auxiliary**: 
  - **Type**: VARCHAR(50)
  - **Description**: The name or description of the auxiliary. This could represent specific boosts like "Nitro Drift," "Car Damage Boost," "Impact Reduction," etc.
  - **Constraints**: Not null.

- **level_id**: 
  - **Type**: INTEGER
  - **Description**: The ID that links the auxiliary to its performance level, indicating the effectiveness of the boost.
  - **Constraints**: Not null.
  - **References**: `levels.id` (Foreign Key).

#### **Notes**:
The `auxiliaries` table is designed to store various game-enhancing features that apply to cars. These auxiliaries improve car performance in different ways, such as by providing boosts to nitro usage, car durability, or damage reduction, depending on the level associated with each entry.

---

### car_configurations

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **card_id** | INTEGER | not null  | car_configurations_card_id_fk | |
| **engine_id** | INTEGER | not null  | car_configurations_engine_id_fk | |
| **class_id** | INTEGER | not null  | car_configurations_class_id_fk | |
| **induction_level** | INTEGER | not null  | car_configurations_induction_level_fk | |
| **ecu_level** | INTEGER | not null  | car_configurations_ecu_level_fk | |
| **injection_level** | INTEGER | not null  | car_configurations_injection_level_fk | |
| **escape_level** | INTEGER | not null  | car_configurations_escape_level_fk | |
| **turbo_id** | INTEGER | not null  | car_configurations_turbo_id_fk | |
| **nitro_level** | INTEGER | not null  | car_configurations_nitro_level_fk | |
| **suspension_id** | INTEGER | not null  | car_configurations_suspension_id_fk | |
| **brake_level** | INTEGER | not null  | car_configurations_brake_level_fk | |
| **tire_id** | INTEGER | not null  | car_configurations_tire_id_fk | |
| **embrague_level** | INTEGER | not null  | car_configurations_embrague_level_fk | |
| **gear_id** | INTEGER | not null  | car_configurations_gear_id_fk | |
| **differential_level** | INTEGER | not null  | car_configurations_differential_level_fk | |
| **top_speed** | INTEGER | not null  |  | |
| **one_hundred** | DECIMAL | not null  |  | |
| **power** | INTEGER | not null  |  | |
| **par** | INTEGER | not null  |  | |
| **four_hundred** | DECIMAL | not null  |  | |
| **driver_id** | INTEGER | not null  | car_configurations_driver_id_fk | |
| **auxiliar_one** | INTEGER | not null  | car_configurations_auxiliar_one_fk | |
| **auxiliar_two** | INTEGER | not null  | car_configurations_auxiliar_two_fk | | 

### **car_configurations Table**

#### **Purpose**:
The `car_configurations` table stores the customized vehicle setups in the game. Each configuration represents a unique combination of car parts, upgrades, and features that affect the overall performance of the vehicle. This table allows players to save and modify their car configurations, including performance details like top speed, acceleration, power, and specific parts such as the engine, wheels, and turbo.

#### **Fields**:
- **id**:
  - **Type**: INTEGER
  - **Description**: A unique identifier for each car configuration (Primary Key).
  - **Constraints**: Not null, unique, auto-incremented.

- **card_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the car being configured. Refers to the specific vehicle associated with the configuration.
  - **Constraints**: Not null.
  - **References**: `car.id` (Foreign Key).

- **engine_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the car's engine. Linked to the specific engine part used in the configuration.
  - **Constraints**: Not null.
  - **References**: `engine.id` (Foreign Key).

- **class_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the car's class, indicating the vehicle's category.
  - **Constraints**: Not null.
  - **References**: `class.id` (Foreign Key).

- **induction_level**:
  - **Type**: INTEGER
  - **Description**: The level of induction for the car, defining the engine's performance boost.
  - **Constraints**: Not null.
  - **References**: `induction_level.id` (Foreign Key).

- **ecu_level**:
  - **Type**: INTEGER
  - **Description**: The level of the ECU (Electronic Control Unit) that determines the car's engine tuning and optimization.
  - **Constraints**: Not null.
  - **References**: `ecu_level.id` (Foreign Key).

- **injection_level**:
  - **Type**: INTEGER
  - **Description**: The fuel injection level of the car, affecting engine efficiency and power.
  - **Constraints**: Not null.
  - **References**: `injection_level.id` (Foreign Key).

- **escape_level**:
  - **Type**: INTEGER
  - **Description**: The exhaust system level of the car, influencing performance and engine output.
  - **Constraints**: Not null.
  - **References**: `escape_level.id` (Foreign Key).

- **turbo_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the turbo system used in the car.
  - **Constraints**: Not null.
  - **References**: `turbo.id` (Foreign Key).

- **nitro_level**:
  - **Type**: INTEGER
  - **Description**: The level of the nitro boost available for the car.
  - **Constraints**: Not null.
  - **References**: `nitro_level.id` (Foreign Key).

- **suspension_id**:
  - **Type**: INTEGER
  - **Description**: The suspension system ID used in the car.
  - **Constraints**: Not null.
  - **References**: `suspension.id` (Foreign Key).

- **brake_level**:
  - **Type**: INTEGER
  - **Description**: The brake system level for the car, which influences braking performance.
  - **Constraints**: Not null.
  - **References**: `brake_level.id` (Foreign Key).

- **tire_id**:
  - **Type**: INTEGER
  - **Description**: The tire ID for the car.
  - **Constraints**: Not null.
  - **References**: `tire.id` (Foreign Key).

- **embrague_level**:
  - **Type**: INTEGER
  - **Description**: The level of the clutch system for the car.
  - **Constraints**: Not null.
  - **References**: `embrague_level.id` (Foreign Key).

- **gear_id**:
  - **Type**: INTEGER
  - **Description**: The gear system ID used in the car.
  - **Constraints**: Not null.
  - **References**: `gear.id` (Foreign Key).

- **differential_level**:
  - **Type**: INTEGER
  - **Description**: The differential system level, which affects handling and traction.
  - **Constraints**: Not null.
  - **References**: `differential_level.id` (Foreign Key).

- **top_speed**:
  - **Type**: INTEGER
  - **Description**: The top speed of the car, influenced by the configuration of various car parts.
  - **Constraints**: Not null.

- **one_hundred**:
  - **Type**: DECIMAL
  - **Description**: The time it takes for the car to accelerate from 0 to 100 km/h (or the equivalent in your game).
  - **Constraints**: Not null.

- **power**:
  - **Type**: INTEGER
  - **Description**: The power output of the car's engine, generally measured in horsepower.
  - **Constraints**: Not null.

- **par**:
  - **Type**: INTEGER
  - **Description**: The torque of the car's engine, often measured in Nm (Newton-meters).
  - **Constraints**: Not null.

- **four_hundred**:
  - **Type**: DECIMAL
  - **Description**: The time it takes for the car to accelerate from 0 to 400 meters.
  - **Constraints**: Not null.

- **driver_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the driver using this car configuration.
  - **Constraints**: Not null.
  - **References**: `driver.id` (Foreign Key).

- **auxiliar_one**:
  - **Type**: INTEGER
  - **Description**: The ID of the first auxiliary boost applied to the car's performance.
  - **Constraints**: Not null.
  - **References**: `auxiliary.id` (Foreign Key).

- **auxiliar_two**:
  - **Type**: INTEGER
  - **Description**: The ID of the second auxiliary boost applied to the car's performance.
  - **Constraints**: Not null.
  - **References**: `auxiliary.id` (Foreign Key).

#### **Notes**:
The `car_configurations` table is designed to store the custom configurations of cars in the game. Each entry in the table represents a specific car configuration, including key performance information such as top speed, 0-100 km/h acceleration time, engine power, and torque. It is also linked to various car components (such as the suspension system, brakes, tires, and turbo system), and to the driver using that configuration, allowing for customization and optimization of the car's performance based on different variables and preferences.

---

### user_car_configurations

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **user_id** | INTEGER | not null  | user_car_configurations_user_id_fk | |
| **car_config_id** | INTEGER | not null  | user_car_configurations_car_config_id_fk | | 

### **user_car_configurations Table**

#### **Purpose**:
The `user_car_configurations` table is designed to store the relationships between users and the car configurations they have chosen or customized in the game. Each entry represents a link between a user and a specific car configuration, allowing users to save their personalized setups and access them in the future.

#### **Fields**:
- **id**:
  - **Type**: INTEGER
  - **Description**: A unique identifier for each user-car configuration entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **user_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the user who owns the car configuration.
  - **Constraints**: Not null.
  - **References**: `users.id` (Foreign Key).

- **car_config_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the car configuration the user has selected or customized.
  - **Constraints**: Not null.
  - **References**: `car_configurations.id` (Foreign Key).

#### **Notes**:
The `user_car_configurations` table serves as a bridge between the `users` table and the `car_configurations` table, linking users to their customized car setups. This allows users to store and retrieve their car configurations for use in the game, ensuring that each user has easy access to their personalized vehicles.

---

### user_car_favorites

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **user_id** | INTEGER | not null  | user_car_favorites_user_id_fk | |
| **user_car_config_id** | INTEGER | not null  | user_car_favorites_user_car_config_id_fk | | 

### **user_car_favorites Table**

#### **Purpose**:
The `user_car_favorites` table is designed to store the favorite car configurations of users in the game. Each entry in the table represents a specific car configuration that a user has marked as a favorite, allowing them to easily access and use their preferred car setups.

#### **Fields**:
- **id**:
  - **Type**: INTEGER
  - **Description**: A unique identifier for each user-car favorite entry (Primary Key).
  - **Constraints**: Not null, unique, auto-increment.

- **user_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the user who has marked the car configuration as a favorite.
  - **Constraints**: Not null.
  - **References**: `users.id` (Foreign Key).

- **user_car_config_id**:
  - **Type**: INTEGER
  - **Description**: The ID of the car configuration that the user has marked as a favorite.
  - **Constraints**: Not null.
  - **References**: `user_car_configurations.id` (Foreign Key).

#### **Notes**:
The `user_car_favorites` table allows users to save their preferred car configurations in the game. This table helps users quickly access their favorite car setups for future use, making it easier to switch between different personalized vehicles.

---

## Relationships

- **operations to modules**: many_to_one
- **operations to granted_permissions**: one_to_many
- **granted_permissions to roles**: many_to_one
- **users to roles**: many_to_one
- **jwt_registers to users**: many_to_one
- **cars to makers**: many_to_one
- **drivers to init_skids**: many_to_one
- **tires to street_types**: many_to_one
- **tires to levels**: many_to_one
- **suspensions to street_types**: many_to_one
- **suspensions to levels**: many_to_one
- **turbos to turbo_types**: many_to_one
- **turbos to levels**: many_to_one
- **gears to levels**: one_to_one
- **engines to levels**: many_to_one
- **auxiliaries to levels**: many_to_one
- **car_configurations to cars**: many_to_one
- **car_configurations to engines**: many_to_one
- **car_configurations to classes**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to turbos**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to suspensions**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to tires**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to levels**: many_to_one
- **car_configurations to drivers**: many_to_one
- **car_configurations to auxiliaries**: many_to_one
- **car_configurations to auxiliaries**: many_to_one
- **car_configurations to gears**: many_to_one
- **user_car_configurations to users**: many_to_one
- **user_car_favorites to users**: many_to_one
- **user_car_favorites to user_car_configurations**: many_to_one
- **user_car_configurations to car_configurations**: many_to_one

## Database Diagram

```mermaid
erDiagram
    operations ||--o{ modules : references
    operations }o--|| granted_permissions : references
    granted_permissions ||--o{ roles : references
    users ||--o{ roles : references
    jwt_registers ||--o{ users : references
    cars ||--o{ makers : references
    drivers ||--o{ init_skids : references
    tires ||--o{ street_types : references
    tires ||--o{ levels : references
    suspensions ||--o{ street_types : references
    suspensions ||--o{ levels : references
    turbos ||--o{ turbo_types : references
    turbos ||--o{ levels : references
    gears ||--|| levels : references
    engines ||--o{ levels : references
    auxiliaries ||--o{ levels : references
    car_configurations ||--o{ cars : references
    car_configurations ||--o{ engines : references
    car_configurations ||--o{ classes : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ turbos : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ suspensions : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ tires : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ levels : references
    car_configurations ||--o{ drivers : references
    car_configurations ||--o{ auxiliaries : references
    car_configurations ||--o{ auxiliaries : references
    car_configurations ||--o{ gears : references
    user_car_configurations ||--o{ users : references
    user_car_favorites ||--o{ users : references
    user_car_favorites ||--o{ user_car_configurations : references
    user_car_configurations ||--o{ car_configurations : references

    modules {
        INTEGER id
        VARCHAR(50) module
        VARCHAR(50) base_path
    }

    operations {
        INTEGER id
        VARCHAR(50) name
        VARCHAR(50) path
        VARCHAR(10) http_method
        TINYINT permit_all
        INTEGER module_id
    }

    roles {
        INTEGER id
        VARCHAR(30) name
    }

    granted_permissions {
        INTEGER id
        INTEGER role_id
        INTEGER operation_id
    }

    users {
        INTEGER id
        VARCHAR(50) name
        VARCHAR(50) username
        VARCHAR(128) password
        VARCHAR(255) email
        INTEGER role_id
        TINYINT account_non_expired
        TINYINT account_non_locked
        TINYINT credentials_non_expired
        TINYINT enabled
        VARCHAR(7) color_profile
        TINYINT is_email_valid
    }

    jwt_registers {
        INTEGER id
        INTEGER user_id
        VARCHAR(2048) token_jwt
        DATETIME expiration
        TINYINT enable
        VARCHAR(255) reference_site
    }

    init_skids {
        INTEGER id
        VARCHAR(45) skid_type
    }

    street_types {
        INTEGER id
        VARCHAR(45) street_type
    }

    classes {
        INTEGER id
        VARCHAR(2) name
    }

    turbo_types {
        INTEGER id
        VARCHAR(30) type
    }

    makers {
        INTEGER id
        VARCHAR(45) name
    }

    levels {
        INTEGER id
        VARCHAR(10) level
    }

    cars {
        INTEGER id
        INTEGER maker_id
        VARCHAR(50) model
        VARCHAR(4) car_year
    }

    drivers {
        INTEGER id
        INTEGER drive
        INTEGER direction
        INTEGER dawn_force
        TINYINT control_traction
        INTEGER init_skid_id
    }

    tires {
        INTEGER id
        INTEGER street_type_id
        INTEGER level_id
    }

    suspensions {
        INTEGER id
        INTEGER street_type_id
        INTEGER level_id
    }

    turbos {
        INTEGER id
        INTEGER turbo_type_id
        INTEGER level_id
    }

    gears {
        INTEGER id
        INTEGER gear_value
        INTEGER level_id
    }

    engines {
        INTEGER id
        INTEGER bhp
        DECIMAL liters
        VARCHAR(30) model
        INTEGER level_id
    }

    auxiliaries {
        INTEGER id
        VARCHAR(50) auxiliar
        INTEGER level_id
    }

    car_configurations {
        INTEGER id
        INTEGER card_id
        INTEGER engine_id
        INTEGER class_id
        INTEGER induction_level
        INTEGER ecu_level
        INTEGER injection_level
        INTEGER escape_level
        INTEGER turbo_id
        INTEGER nitro_level
        INTEGER suspension_id
        INTEGER brake_level
        INTEGER tire_id
        INTEGER embrague_level
        INTEGER gear_id
        INTEGER differential_level
        INTEGER top_speed
        DECIMAL one_hundred
        INTEGER power
        INTEGER par
        DECIMAL four_hundred
        INTEGER driver_id
        INTEGER auxiliar_one
        INTEGER auxiliar_two
    }

    user_car_configurations {
        INTEGER id
        INTEGER user_id
        INTEGER car_config_id
    }

    user_car_favorites {
        INTEGER id
        INTEGER user_id
        INTEGER user_car_config_id
    }
```
![design-sdd-database1](sdd-catalog1.png)
![design-sdd-database2](sdd-catalog2.png)
![design-sdd-database3](app_performance.jpg)