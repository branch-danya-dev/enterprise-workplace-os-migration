# Workplace Profiles and Environment Dependencies

This document preserves the reconstructed **AS-IS workplace context** needed to understand why migration readiness could not be evaluated through one universal scenario.

It describes workplace characteristics. The readiness consequence of these characteristics is owned by [`../readiness/`](../readiness/).

## Workplace as an environment

Before migration, a workplace could depend on a combination of:

- user identity and access rights;
- workstation hardware;
- Windows operating environment;
- mandatory corporate software;
- internal web applications;
- corporate infrastructure services;
- network resources;
- information-security controls;
- user/role-specific software;
- authentication mechanisms;
- remote-access mechanisms where applicable.

This is why the migration target cannot be modeled as an OS image alone.

## Standard office workplace

A typical office workplace included standard components such as:

- corporate office suite;
- Yandex Browser;
- Kaspersky antivirus/security software;
- network folders/resources;
- required internal web applications.

Examples of corporate applications/services in the sanitized reconstruction include:

- PSB Academy;
- Newton;
- Confluence;
- Jira;
- Thesis;
- Inframanager;
- corporate email;
- Molniya messenger;
- Active Directory and related enterprise access/infrastructure services.

These names are context examples, not a claim that SSAD needs to model each service internally.

## Office User

A standard office user works directly from an assigned workplace in the corporate office environment.

Expected dependencies:

```text
standard workplace environment
+
role-specific software where needed
+
required corporate services/access
```

## Remote User

A remote-work scenario can add a separate access chain.

The reconstructed example includes:

```text
Astra Linux laptop
→ VPN
→ CryptoPro token authentication
→ remote desktop connection
→ assigned corporate workstation
```

Relevant dependencies may therefore include:

- VPN availability;
- CryptoPro token;
- certificate validity;
- remote-desktop infrastructure;
- target workplace availability.

The migration model consumes the consequence of these dependencies; VPN/authentication internals remain external ownership domains.

## Restricted-Environment User

A restricted workplace can have stronger authentication/security dependencies.

The reconstructed case includes a personal certificate/key and controlled authentication device associated with the user.

Additional dependencies:

- personal certificate;
- authentication device;
- certificate lifecycle;
- information-security policy/approval.

Loss of a controlled authentication asset is an information-security concern, not a workplace-migration rule invented by this repository.

## Developer

Developer workplaces can require:

- IDEs;
- libraries/toolchains;
- access to development environments;
- role-specific permissions;
- adjacent-team approvals.

The important migration question is whether the required development capability remains available in the target workplace environment.

## Specialized Workplace

Other business functions may require specialized software, peripherals or permissions managed by dedicated teams.

These workplaces are not exceptional merely because they differ from the office baseline. Their additional dependencies become part of readiness evidence.

## Why profiles matter

The profile is not intended to be a rigid taxonomy for every workplace.

Its analytical purpose is to identify likely dependency classes quickly.

```text
Workplace profile
→ expected dependency set
→ actual workplace evidence
→ readiness analysis
```

A profile must never replace analysis of the real workplace when user-specific dependencies differ from the baseline.

## Dependency ownership

| Dependency | Migration meaning | Canonical/external authority |
|---|---|---|
| standard software | required workplace capability | Workplace context + software support evidence |
| specialized software | role-specific capability | specialized/software domain |
| network/corporate services | required access capability | corresponding infrastructure/service domain |
| certificates/tokens | security/authentication capability | security/authentication domain |
| VPN/remote desktop | remote-work capability | remote-access/infrastructure domain |
| IDE/toolchain | development capability | development/software support domain |
| peripherals/drivers | physical workplace capability | workplace/hardware support evidence |

The migration model tracks whether a dependency affects migration; it does not absorb ownership of every underlying system.

## Relationship to readiness

The same software or service can have different migration importance for different users.

```text
dependency exists
+
is required for this business activity
+
target solution inadequate
→ readiness impact
```

Therefore dependency lists should not be interpreted without the required business capability.

## Legacy source

This document absorbs the reusable workplace-context knowledge from `docs/02-as-is.md` and complements the system boundary from the former `docs/01-context-and-scope.md`.
