import toastr from "toastr";
import "../../node_modules/toastr/build/toastr.min.css";

toastr.options = {
  closeButton: false,
  debug: false,
  newestOnTop: false,
  progressBar: false,
  positionClass: "toast-top-right",
  preventDuplicates: false,
  onclick: null,
  showDuration: "300",
  hideDuration: "1000",
  timeOut: "5000",
  extendedTimeOut: "1000",
  showEasing: "swing",
  hideEasing: "linear",
  showMethod: "fadeIn",
  hideMethod: "fadeOut",
};

const successText = $(".js-alert-info").text();

if (successText) {
  toastr["success"](successText);
}

const dangerText = $(".js-alert-danger").text();

if (dangerText) {
  toastr["warning"](dangerText);
}

export default toastr;
