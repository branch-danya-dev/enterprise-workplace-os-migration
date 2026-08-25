# AS-IS: Current Workplace Environment

## Purpose

This document describes the workplace environment before migration from
Microsoft Windows to Astra Linux.

The purpose of the AS-IS model is to identify the components and dependencies
that determine whether a user workplace can be migrated without disrupting
normal business activity.

## Workplace as a System

A workplace was not limited to a physical workstation and operating system.

The working environment included:

- user identity and access rights;
- workstation hardware;
- operating system;
- mandatory corporate software;
- access to internal web applications;
- corporate infrastructure services;
- network resources;
- information security controls;
- user-specific and role-specific software;
- authentication mechanisms;
- remote-access mechanisms where applicable.

The migration therefore affected the complete workplace environment rather
than the operating system alone.

## Standard Office Workplace

A standard office workplace based on Windows included the following mandatory
components:

### Standard software

- corporate office suite;
- Yandex Browser;
- Kaspersky antivirus;
- access to network folders;
- access to required internal web applications.

### Mandatory corporate web applications

Examples included:

- PSB Academy;
- Newton;
- Confluence;
- Jira;
- Thesis;
- Inframanager.

These applications supported training, internal communication, documentation,
task management, service management and operational workflows.

## Corporate Services and Infrastructure

Workplaces depended on a number of enterprise services.

Typical dependencies included:

- Active Directory;
- corporate email;
- Molniya corporate messenger;
- Newton corporate forum;
- internal web applications;
- network drives;
- information security systems;
- automatic software update systems;
- corporate portals.

Availability of the operating system alone did not guarantee workplace
readiness if access to the required corporate services was unavailable.

## Workplace Profiles

Workplaces differed depending on the user's working mode and business role.

### Office User

A standard office user worked directly from an assigned workstation in the
corporate office environment.

The workplace included the standard software and corporate services described
above.

Additional software could be provided depending on the user's business role.

### Remote User

A remote user worked through a corporate remote-access environment.

The user's access device was a corporate laptop with Astra Linux installed.

The typical access flow included:

Astra Linux laptop
→ VPN
→ CryptoPro token authentication
→ remote desktop connection
→ assigned corporate workstation

Remote access depended on:

- VPN availability;
- CryptoPro token;
- certificate validity;
- remote desktop infrastructure;
- availability of the target workstation.

### Restricted-Environment User

Users operating in a restricted environment worked from the office but had
additional authentication requirements.

Access to the workstation required a personal certificate/key assigned to the
specific user.

The authentication device was treated as a controlled security asset and its
loss represented an information-security incident.

This workplace profile therefore had additional dependencies on:

- personal certificate;
- authentication device;
- certificate lifecycle;
- information-security policies.

### Developer

Developer workplaces required additional technical tools and access rights.

Typical dependencies included:

- development IDEs;
- required libraries and development tools;
- access to development environments;
- role-specific permissions.

Access provisioning and approval involved adjacent support teams and
information-security teams.

### Specialized Workplace

Other workplace profiles could require specialized software depending on the
business function.

Such software and permissions were managed by dedicated support teams and
required information-security approval.

Therefore, migration readiness for these workplaces depended not only on the
standard Astra Linux environment but also on the availability and
compatibility of the required specialized tools.

## Responsibility Boundaries

The workplace support area was responsible for the user workplace environment
and migration-related issues directly associated with it.

Adjacent teams were responsible for areas such as:

- specialized application access;
- security approvals;
- development-specific access;
- authentication infrastructure;
- selected enterprise services.

Although these areas were outside direct ownership, their dependencies had to
be considered during migration analysis.

## AS-IS Dependency Model

A simplified dependency model can be represented as:

User
↓
Workplace Profile
↓
Operating System
↓
Standard Software
↓
Specialized Software
↓
Access Rights
↓
Corporate Services
↓
Security Controls
↓
Business Activity

A failure or compatibility issue at any level could prevent successful
migration.

## Key AS-IS Constraint

The Windows environment had accumulated a large number of user-specific,
department-specific and role-specific dependencies.

Because workplace profiles differed significantly, migration could not be
performed using a single universal scenario.

Migration readiness therefore required analysis of:

- workplace profile;
- required software;
- access dependencies;
- security requirements;
- business criticality;
- compatibility with Astra Linux.