import { application } from "./application"

import PasswordVisibilityController from "./password_visibility_controller"
application.register("password-visibility", PasswordVisibilityController)

import ConfirmDeleteController from "./confirm_delete_controller"
application.register("confirm-delete", ConfirmDeleteController)

import MentionAutocompleteController from "./mention_autocomplete_controller"
application.register("mention-autocomplete", MentionAutocompleteController)
