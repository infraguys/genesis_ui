import './inventory.dart';

List<Inventory> dummyInventories = _json.map((json) {
  if (json
      case {
        'event': final String event,
        'description': final String description,
        'time': final String time,
        'status': final String status,
      }) {
    return Inventory(
      event: event,
      description: description,
      time: time,
      status: status,
    );
  } else {
    throw const FormatException('Unexpected JSON');
  }
}).toList();

// Generated by ChatGPT
const _json = [
  {
    'event': 'User deleted',
    'description': 'The user has been removed from the system.',
    'time': '2025-05-11 17:30:00',
    'status': 'REMOVED',
  },
  {
    'event': 'Node resize',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 has been resized.',
    'time': '2025-05-11 16:05:00',
    'status': 'STARTED',
  },
  {
    'event': 'User updated',
    'description': 'User information was successfully updated.',
    'time': '2025-05-11 17:00:00',
    'status': 'COMPLETED',
  },
  {
    'event': 'Node active',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 is actively processing.',
    'time': '2025-05-11 16:10:00',
    'status': 'ACTIVE',
  },
  {
    'event': 'Node started',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 has started processing.',
    'time': '2025-05-11 16:05:00',
    'status': 'STARTED',
  },
  {
    'event': 'User checked',
    'description': 'The user test@user.com was checked and no issues were found.',
    'time': '2025-05-11 16:46:00',
    'status': 'ACTIVE',
  },
  {
    'event': 'User added',
    'description': 'A new user was registered in the system.',
    'time': '2025-05-11 16:45:00',
    'status': 'NEW',
  },
  {
    'event': 'Node scheduled',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 has been scheduled for execution.',
    'time': '2025-05-11 16:00:00',
    'status': 'SCHEDULED',
  },
  {
    'event': 'Node created',
    'description': 'The new node was create with UUID 12345678-1234-1234-1234-123456789012.',
    'time': '2025-05-11 15:45:00',
    'status': 'NEW',
  },
    {
    'event': 'User deleted',
    'description': 'The user has been removed from the system.',
    'time': '2025-05-11 17:30:00',
    'status': 'REMOVED',
  },
  {
    'event': 'Node resize',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 has been resized.',
    'time': '2025-05-11 16:05:00',
    'status': 'STARTED',
  },
  {
    'event': 'User updated',
    'description': 'User information was successfully updated.',
    'time': '2025-05-11 17:00:00',
    'status': 'COMPLETED',
  },
  {
    'event': 'Node active',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 is actively processing.',
    'time': '2025-05-11 16:10:00',
    'status': 'ACTIVE',
  },
  {
    'event': 'Node started',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 has started processing.',
    'time': '2025-05-11 16:05:00',
    'status': 'STARTED',
  },
  {
    'event': 'User checked',
    'description': 'The user test@user.com was checked and no issues were found.',
    'time': '2025-05-11 16:46:00',
    'status': 'ACTIVE',
  },
  {
    'event': 'User added',
    'description': 'A new user was registered in the system.',
    'time': '2025-05-11 16:45:00',
    'status': 'NEW',
  },
  {
    'event': 'Node scheduled',
    'description': 'The node with UUID 12345678-1234-1234-1234-123456789012 has been scheduled for execution.',
    'time': '2025-05-11 16:00:00',
    'status': 'SCHEDULED',
  },
  {
    'event': 'Node created',
    'description': 'The new node was create with UUID 12345678-1234-1234-1234-123456789012.',
    'time': '2025-05-11 15:45:00',
    'status': 'NEW',
  },
];
