# **HL7 AU FHIR Core Inferno Test Suite Release Strategy**

## **1. Overview**
This release strategy establishes a framework for versioning, release management, and iterative development for HL7 AU FHIR Core Inferno Test Suite.

## **2. Versioning Strategy**
The versioning approach follows **a modified Semantic Versioning (semver) strategy** aligned with HL7 AU conventions:

### ** Release Version Format: `MAJOR.MINOR.PATCH`**
- **MAJOR** (`X.0.0`) – Indicates a major milestone or significant changes, often aligning with a L7 AU FHIR Core Release.
- **MINOR** (`X.Y.0`) – Used for incremental releases within a major version.
- **PATCH** (`X.Y.Z`) – Represents small fixes, technical corrections, and refinements to existing test data without introducing breaking changes.

Each release is also marked with a Git tag using the format `v<MAJOR>.<MINOR>.<PATCH>` (e.g., `v1.0.0`) to capture an immutable snapshot of the repository at a release milestone. 

## 3. Release Process  

### 3.1 Pre-requisites: Development & Testing  
- All changes are merged into `master`.  

### 3.2 Release Triggers
- A release may be initiated once `master` reaches a milestone, such as:
  - New version of HL7 AU FHIR Core is released
  - Implementing significant feature enhancements or fixes to tests or supporting tooling.

### 3.3 Preparing the Release 
- Perform final testing and apply necessary fixes before proceeding with the release.
- Assign a release version based on the **versioning strategy** outlined above.  
- Create a **Git tag** (e.g., `v1.0.0`) from `master` to mark the release based on the assigned version.
- Notes:
  - Release artifacts: Releases do not include test generator tools, however, the generator remains in the repository to support test suite generation.
  - Release branching: A dedicated release branch is not required, git tags is used instead. However, release branches may be introduced in the future if needed.  
- Finalise **release notes** which includes a summary of features, updates, fixes, and a release-specific README.md.

### 3.4 Post-Release Development and Community Involvement 
- Announce the release e.g., via HL7 AU Infrastructure and Tooling calls and chat.fhir.org.
- Further development continues on `master`, preparing for the next release cycle.  
- Community contributions via GitHub issues.
- Updates based on user feedback, testing event outcomes, and IG changes.
- Continuous improvement to tooling for synthetic test data generation, supporting tooling including CI pipelines.


















