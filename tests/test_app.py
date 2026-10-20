
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "app"))

from app import app


def test_home_endpoint():
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200

    data = response.get_json()
    assert data["application"] == "GitOps Kubernetes Platform"
    assert data["message"] == "Application is running!"
    assert data["version"] == "1.0.0"


def test_health_endpoint():
    client = app.test_client()

    response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json() == {"status": "healthy"}
