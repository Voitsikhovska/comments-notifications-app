import { application } from "./application"

import PasswordVisibilityController from "./password_visibility_controller"
application.register("password-visibility", PasswordVisibilityController)

import ConfirmDeleteController from "./confirm_delete_controller"
application.register("confirm-delete", ConfirmDeleteController)
