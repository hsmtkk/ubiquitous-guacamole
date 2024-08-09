resource "google_service_account" "cloudbuild_sa" {
  account_id = "cloudbuild-sa"
  project    = var.project_id
}

# resource "google_project_iam_member" "cloudbuild_sa_service_account" {
#   project = var.project_id
#   role    = "roles/iam.serviceAccountUser"
#   member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
# }

resource "google_service_account_iam_member" "cloudbuild_sa_service_account" {
  service_account_id = google_service_account.cloudbuild_sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild_sa_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_sa_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_sa_functions_admin" {
  project = var.project_id
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

resource "google_cloudbuild_trigger" "the_trigger" {
  filename = "cloudbuild.yaml"
  github {
    owner = var.owner
    name  = var.repository
    push {
      branch = "^main$"
    }
  }
  location        = var.location
  project         = var.project_id
  service_account = google_service_account.cloudbuild_sa.id
}


