"""Test the validity of all  dags."""
import pytest

from airflow.utils.dag_cycle_tester import test_cycle


def test_import_errors(test_dag_bag):
    """
    Tests that the DAG files can be imported by Airflow without errors.
    ie.
        - No exceptions were raised when processing the DAG files, be it timeout or other exceptions
        - The DAGs are indeed acyclic
            DagBag.bag_dag() checks for dag.test_cycle()
    """
    assert len(test_dag_bag.import_errors) == 0


def test_dags_has_task(test_dag_bag):
    for dag in test_dag_bag.dags.values():
        assert len(dag.tasks) > 0


def test_no_cyclic_dags(test_dag_bag):
    for dag in test_dag_bag.dags.values():
        assert test_cycle(dag) is None


def test_alert_email_present(test_dag_bag):
    for dag_id, dag in test_dag_bag.dags.items():
        emails = dag.default_args.get("email", [])
        "Alert email not set for DAG {id}".format(id=dag_id)
        if ["end-to-end-test-ci-cd", "test_email"].count(dag_id) == 0:
            assert len(emails) > 0
