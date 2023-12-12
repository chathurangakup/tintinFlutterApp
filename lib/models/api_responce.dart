class ApiResponse<T>{
  T data;
  bool error;
  String errormessage;

  ApiResponse({required this.data,required this.errormessage,this.error=false});
}