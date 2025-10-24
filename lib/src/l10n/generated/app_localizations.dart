import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('ru')];

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @genesis.
  ///
  /// In en, this message translates to:
  /// **'Genesis'**
  String get genesis;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get createdAt;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get updatedAt;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @surName.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @virtualMachine.
  ///
  /// In en, this message translates to:
  /// **'Virtual machine'**
  String get virtualMachine;

  /// No description provided for @hardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get hardware;

  /// No description provided for @cores.
  ///
  /// In en, this message translates to:
  /// **'Cores'**
  String get cores;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @core.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get core;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectName;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'Two-factor authentication'**
  String get otp;

  /// No description provided for @deleteRole.
  ///
  /// In en, this message translates to:
  /// **'Delete role {name}?'**
  String deleteRole(String name);

  /// No description provided for @deleteRoles.
  ///
  /// In en, this message translates to:
  /// **'Delete selected({count}) roles?'**
  String deleteRoles(int count);

  /// No description provided for @deleteProjectConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete project {name}?'**
  String deleteProjectConfirmation(String name);

  /// No description provided for @deleteProjectsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete selected({count}) projects?'**
  String deleteProjectsConfirmation(int count);

  /// No description provided for @deleteNodeConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete node {name}?'**
  String deleteNodeConfirmation(String name);

  /// No description provided for @deleteNodesConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete selected({count}) nodes?'**
  String deleteNodesConfirmation(int count);

  /// No description provided for @deletePgClusterConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete cluster {name}?'**
  String deletePgClusterConfirmation(String name);

  /// No description provided for @deleteClustersConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete selected({count}) clusters?'**
  String deleteClustersConfirmation(int count);

  /// No description provided for @deleteOrganizationConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete organization {name}?'**
  String deleteOrganizationConfirmation(String name);

  /// No description provided for @deleteOrganizationsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete selected({count}) organizations?'**
  String deleteOrganizationsConfirmation(int count);

  /// No description provided for @deleteUser.
  ///
  /// In en, this message translates to:
  /// **'Delete user {name}?'**
  String deleteUser(String name);

  /// No description provided for @deleteUsers.
  ///
  /// In en, this message translates to:
  /// **'Delete selected ({count}) users?'**
  String deleteUsers(int count);

  /// No description provided for @uuid.
  ///
  /// In en, this message translates to:
  /// **'Uuid'**
  String get uuid;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @roles.
  ///
  /// In en, this message translates to:
  /// **'Roles'**
  String get roles;

  /// No description provided for @element.
  ///
  /// In en, this message translates to:
  /// **'Element'**
  String get element;

  /// No description provided for @elements.
  ///
  /// In en, this message translates to:
  /// **'Elements'**
  String get elements;

  /// No description provided for @allElements.
  ///
  /// In en, this message translates to:
  /// **'All elements'**
  String get allElements;

  /// No description provided for @installed.
  ///
  /// In en, this message translates to:
  /// **'Installed'**
  String get installed;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @organizations.
  ///
  /// In en, this message translates to:
  /// **'Organizations'**
  String get organizations;

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @nodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get nodes;

  /// No description provided for @nodeType.
  ///
  /// In en, this message translates to:
  /// **'Node type'**
  String get nodeType;

  /// No description provided for @dbaas.
  ///
  /// In en, this message translates to:
  /// **'DBaaS'**
  String get dbaas;

  /// No description provided for @pgCluster.
  ///
  /// In en, this message translates to:
  /// **'PG Cluster'**
  String get pgCluster;

  /// No description provided for @iam.
  ///
  /// In en, this message translates to:
  /// **'Iam'**
  String get iam;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @confirmEmail.
  ///
  /// In en, this message translates to:
  /// **'Confirm email'**
  String get confirmEmail;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// No description provided for @pgClusterName.
  ///
  /// In en, this message translates to:
  /// **'PostgreSQL cluster name'**
  String get pgClusterName;

  /// No description provided for @ramLabelText.
  ///
  /// In en, this message translates to:
  /// **'Ram (MB)'**
  String get ramLabelText;

  /// No description provided for @nodeCountHelperText.
  ///
  /// In en, this message translates to:
  /// **'Node count'**
  String get nodeCountHelperText;

  /// No description provided for @diskSize.
  ///
  /// In en, this message translates to:
  /// **'Disk size (GB)'**
  String get diskSize;

  /// No description provided for @versionHelperText.
  ///
  /// In en, this message translates to:
  /// **'Link to PostgreSQL version'**
  String get versionHelperText;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @msgCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard: {uuid}'**
  String msgCopiedToClipboard(String uuid);

  /// No description provided for @msgPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have the required permissions. Please contact your administrator. Missing:\n{permission}'**
  String msgPermissionDenied(String permission);

  /// No description provided for @msgUserCreated.
  ///
  /// In en, this message translates to:
  /// **'User {username} has been created'**
  String msgUserCreated(String username);

  /// No description provided for @msgUserUpdated.
  ///
  /// In en, this message translates to:
  /// **'User {username} has been updated'**
  String msgUserUpdated(String username);

  /// No description provided for @msgUserDeleted.
  ///
  /// In en, this message translates to:
  /// **'User {username} has been deleted'**
  String msgUserDeleted(String username);

  /// No description provided for @msgUsersDeleted.
  ///
  /// In en, this message translates to:
  /// **'Users({count}) have been deleted'**
  String msgUsersDeleted(int count);

  /// No description provided for @msgOrganizationCreated.
  ///
  /// In en, this message translates to:
  /// **'Organization {name} has been created'**
  String msgOrganizationCreated(String name);

  /// No description provided for @msgOrganizationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Organization {name} has been updated'**
  String msgOrganizationUpdated(String name);

  /// No description provided for @msgOrganizationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Organization {name} has been deleted'**
  String msgOrganizationDeleted(String name);

  /// No description provided for @msgOrganizationsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Organizations({count}) have been deleted'**
  String msgOrganizationsDeleted(int count);

  /// No description provided for @msgRoleUpdated.
  ///
  /// In en, this message translates to:
  /// **'Role {name} has been updated'**
  String msgRoleUpdated(String name);

  /// No description provided for @msgRoleDeleted.
  ///
  /// In en, this message translates to:
  /// **'Role {name} has been deleted'**
  String msgRoleDeleted(String name);

  /// No description provided for @msgNodeCreated.
  ///
  /// In en, this message translates to:
  /// **'Node {name} has been created'**
  String msgNodeCreated(String name);

  /// No description provided for @msgNodeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Node {name} has been updated'**
  String msgNodeUpdated(String name);

  /// No description provided for @msgNodeDeleted.
  ///
  /// In en, this message translates to:
  /// **'Node {name} has been deleted'**
  String msgNodeDeleted(String name);

  /// No description provided for @msgProjectCreated.
  ///
  /// In en, this message translates to:
  /// **'Project {name} has been created'**
  String msgProjectCreated(String name);

  /// No description provided for @msgProjectUpdated.
  ///
  /// In en, this message translates to:
  /// **'Project {name} has been updated'**
  String msgProjectUpdated(String name);

  /// No description provided for @msgClusterCreated.
  ///
  /// In en, this message translates to:
  /// **'Cluster {name} has been created'**
  String msgClusterCreated(String name);

  /// No description provided for @msgClusterUpdated.
  ///
  /// In en, this message translates to:
  /// **'Cluster {name} has been updated'**
  String msgClusterUpdated(String name);

  /// No description provided for @msgClusterDeleted.
  ///
  /// In en, this message translates to:
  /// **'Cluster {name} has been deleted'**
  String msgClusterDeleted(String name);

  /// No description provided for @msgClustersDeleted.
  ///
  /// In en, this message translates to:
  /// **'Clusters({count}) have been deleted'**
  String msgClustersDeleted(int count);

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @newStatus.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newStatus;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get started;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
