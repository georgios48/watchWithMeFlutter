// TODO: to be changed if needed
const _baseURL = "http://192.168.0.44:8000";

class UserRoutes {
  final userRegistrationURL = "$_baseURL/user/register";
  final userLoginURL = "$_baseURL/login";
  final resendActivationEmailURL = "$_baseURL/user/resend_email";
  final userAccountURL = "$_baseURL/account";
  final logoutUserURL = "$_baseURL/logout";
}

class RoomRoutes {
  final roomsURL = "$_baseURL/room";
  final extendedRoomsURL = "$_baseURL/room/extended_view";
}
