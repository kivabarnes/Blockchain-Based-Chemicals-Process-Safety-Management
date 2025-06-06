# Blockchain-Based Chemicals Process Safety Management

A comprehensive blockchain solution for managing chemical manufacturing safety, built on the Stacks blockchain using Clarity smart contracts.

## Overview

This system provides a decentralized platform for chemical companies to manage safety processes, regulatory compliance, incident reporting, and emergency response coordination. All data is stored immutably on the blockchain, ensuring transparency and accountability.

## Features

### 🏭 Company Verification
- Register chemical manufacturing companies
- Verify company credentials and licenses
- Track verification status and history

### 📊 Process Monitoring
- Real-time monitoring of chemical processes
- Track temperature, pressure, and pH levels
- Automated safety limit checking
- Process status management

### 🚨 Safety Incident Management
- Report and track safety incidents
- Severity classification (1-5 scale)
- Incident status updates and resolution tracking
- Critical incident identification

### 📋 Regulatory Compliance
- Manage compliance records for various regulations
- Track audit schedules and results
- Compliance status monitoring
- Automated audit due date alerts

### 🚑 Emergency Response
- Emergency declaration and coordination
- Priority-based response system
- Response team assignment
- Response time tracking

## Smart Contracts

### 1. Company Verification Contract (`company-verification.clar`)
Manages the registration and verification of chemical companies.

**Key Functions:**
- \`register-company\`: Register a new chemical company
- \`verify-company\`: Verify a company (owner only)
- \`get-company\`: Retrieve company information
- \`is-company-verified\`: Check verification status

### 2. Process Monitoring Contract (`process-monitoring.clar`)
Monitors chemical manufacturing processes in real-time.

**Key Functions:**
- \`start-process-monitoring\`: Begin monitoring a process
- \`update-process-parameters\`: Update process readings
- \`stop-process-monitoring\`: Stop monitoring
- \`check-safety-limits\`: Verify parameters are within safe ranges

### 3. Safety Incident Contract (`safety-incident.clar`)
Manages safety incident reporting and tracking.

**Key Functions:**
- \`report-incident\`: Report a new safety incident
- \`update-incident-status\`: Update incident status
- \`get-incident\`: Retrieve incident details
- \`is-critical-incident\`: Check if incident is critical (severity 4-5)

### 4. Regulatory Compliance Contract (`regulatory-compliance.clar`)
Ensures regulatory compliance tracking and management.

**Key Functions:**
- \`create-compliance-record\`: Create new compliance record
- \`update-compliance-status\`: Update compliance status
- \`get-compliance-record\`: Retrieve compliance information
- \`is-audit-due\`: Check if audit is due

### 5. Emergency Response Contract (`emergency-response.clar`)
Coordinates emergency response activities.

**Key Functions:**
- \`declare-emergency\`: Declare a chemical emergency
- \`assign-response-team\`: Assign response team
- \`resolve-emergency\`: Mark emergency as resolved
- \`is-high-priority\`: Check if emergency is high priority

## Safety Parameters

### Process Monitoring Limits
- **Temperature**: Maximum 100°C
- **Pressure**: Maximum 50 PSI
- **pH Level**: Range 6.0 - 8.0

### Incident Severity Scale
1. **Minor**: Small spills, minor equipment issues
2. **Low**: Localized incidents, minimal risk
3. **Moderate**: Moderate risk, requires attention
4. **High**: Significant risk, immediate action required
5. **Critical**: Severe risk, emergency response needed

### Emergency Priority Levels
1. **High Priority**: Immediate response required
2. **Medium Priority**: Response within hours
3. **Low Priority**: Response within days

## Installation

1. Clone the repository
2. Install Clarinet CLI
3. Deploy contracts to Stacks blockchain

\`\`\`bash
git clone <repository-url>
cd blockchain-chemical-safety
clarinet deploy
\`\`\`

## Testing

Run the test suite using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover all contract functions and edge cases, ensuring reliability and security.

## Usage Examples

### Register a Company
\`\`\`clarity
(contract-call? .company-verification register-company
"ChemCorp Industries"
"123 Chemical Lane"
"CHEM-2024-001")
\`\`\`

### Start Process Monitoring
\`\`\`clarity
(contract-call? .process-monitoring start-process-monitoring
u1
"Chemical Synthesis A"
u75
u30
u7)
\`\`\`

### Report Safety Incident
\`\`\`clarity
(contract-call? .safety-incident report-incident
u1
u1
u3
"Minor chemical spill in production area")
\`\`\`

## Security Features

- **Access Control**: Function-level permissions
- **Data Validation**: Input parameter validation
- **Immutable Records**: Blockchain-based data storage
- **Audit Trail**: Complete transaction history

## Compliance Standards

This system is designed to support compliance with:
- EPA Chemical Safety Regulations
- OSHA Process Safety Management
- ISO 45001 Occupational Health and Safety
- Local chemical handling regulations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

## License

MIT License - see LICENSE file for details

## Support

For technical support or questions, please open an issue in the repository.
