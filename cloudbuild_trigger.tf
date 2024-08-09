resource "google_service_account" "cloudbuild_sa" {
  account_id = "cloudbuild-sa"
  project    = var.project_id
}

resource "google_project_iam_member" "cloudbuild_sa" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
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


