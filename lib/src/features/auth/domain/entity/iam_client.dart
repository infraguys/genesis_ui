import 'package:genesis/src/features/auth/domain/entity/user.dart';

import 'organization.dart';

class IamClient {
  IamClient({required this.user, required this.organizations});

  final User user;
  final List<Organization> organizations;
}

/**
 *  {
    "user": {
    "uuid": "00000000-0000-0000-0000-000000000000",
    "name": "admin",
    "description": "System administrator",
    "created_at": "2025-05-15 11:01:57.056852",
    "updated_at": "2025-05-15 11:01:57.056852",
    "status": "ACTIVE",
    "first_name": "Admin",
    "last_name": "User",
    "surname": "",
    "phone": null,
    "email": "admin@example.com",
    "email_verified": false,
    "otp_enabled": false
    },
    "organization": [
    {
    "uuid": "00000000-0000-0000-0000-000000000000",
    "name": "admin",
    "description": "Admin Organization",
    "created_at": "2025-05-15 11:01:57.056852",
    "updated_at": "2025-05-15 11:01:57.056852",
    "status": "ACTIVE",
    "info": "{}"
    },
    {
    "uuid": "e4b02a3c-e2a1-4097-9ce7-9ea6d8cd66f5",
    "name": "fake",
    "description": "Fake ORG for A&P command",
    "created_at": "2025-05-15 14:56:20.539385",
    "updated_at": "2025-05-15 14:56:20.539394",
    "status": "ACTIVE",
    "info": "{\"position\":\"localhost <3\"}"
    }
    ],
    "project_id": null
    }
 *
 */
