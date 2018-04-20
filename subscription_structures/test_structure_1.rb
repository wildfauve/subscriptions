# This is our "Tenant" Structure
# See ./images/neo_test_graph_1.png for a view of the graph
HIERARCHICAL_ORGANISATION_GRAPH = {
  nodes: [
    { type: "organisation",   resource: "/party/org/land_corp_holding" },
    { type: "organisation",   resource: "/party/org/land_corp_ajax" },
    { type: "organisation",   resource: "/party/org/land_corp_aoraki" },
    { type: "person",         resource: "/party/person/a" },
    { type: "person",         resource: "/party/person/b" },
    { type: "person",         resource: "/party/person/c" },
    { type: "billing_entity", resource: "/billing_entity/land_corp_holding" },
    { type: "ag_op",          resource: "/ag_op/ajax" },
    { type: "ag_op",          resource: "/ag_op/aoraki" },
    { type: "animal_group",   resource: "/ag/ajax" },
    { type: "animal_group",   resource: "/ag/aoraki" }
  ],
  edges: [
    { "source": "/party/org/land_corp_holding", "target": "/party/org/land_corp_ajax",          "relation": "urn:lic:graph:rel:holding"},
    { "source": "/party/org/land_corp_holding", "target": "/party/org/land_corp_aoraki",        "relation": "urn:lic:graph:rel:holding"},
    { "source": "/party/org/land_corp_holding", "target": "/party/person/1",                    "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/land_corp_ajax",    "target": "/party/person/2",                    "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/land_corp_aoraki",  "target": "/party/person/3",                    "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/land_corp_holding", "target": "/billing_entity/land_corp_holding",  "relation": "urn:lic:graph:rel:financial_acct"},
    { "source": "/party/org/land_corp_ajax",    "target": "/ag_op/ajax",                        "relation": "urn:lic:graph:rel:farming_operation"},
    { "source": "/party/org/land_corp_aoraki",  "target": "/ag_op/aoraki",                      "relation": "urn:lic:graph:rel:farming_operation"},
    { "source": "/ag_op/ajax",                  "target": "/ag/ajax",                           "relation": "urn:lic:graph:rel:animal_mgmt"},
    { "source": "/ag_op/aoraki",                "target": "/ag/aoraki",                         "relation": "urn:lic:graph:rel:animal_mgmt"}
  ]
}

CONSULTING_COHORT_ORGANISATION_GRAPH = {
  nodes: [
    { type: "organisation",   resource: "/party/org/land_corp_holding" },
    { type: "organisation",   resource: "/party/org/land_corp_ajax" },
    { type: "organisation",   resource: "/party/org/land_corp_aoraki" },
    { type: "person",         resource: "/party/person/a" },
    { type: "person",         resource: "/party/person/b" },
    { type: "person",         resource: "/party/person/c" },
    { type: "billing_entity", resource: "/billing_entity/land_corp_holding" },
    { type: "ag_op",          resource: "/ag_op/ajax" },
    { type: "ag_op",          resource: "/ag_op/aoraki" },
    { type: "animal_group",   resource: "/ag/ajax" },
    { type: "animal_group",   resource: "/ag/aoraki" }
  ],
  edges: [
    { "source": "/party/org/land_corp_holding", "target": "/party/org/land_corp_ajax",      "relation": "urn:lic:graph:rel:holding"},
    { "source": "/party/org/land_corp_holding", "target": "/party/org/land_corp_aoraki",      "relation": "urn:lic:graph:rel:holding"},
    { "source": "/party/org/land_corp_holding", "target": "/party/person/1",   "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/land_corp_ajax", "target": "/party/person/2",   "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/land_corp_aoraki", "target": "/party/person/3",   "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/land_corp_holding", "target": "/billing_entity/land_corp_holding", "relation": "urn:lic:graph:rel:financial_acct"},
    { "source": "/party/org/land_corp_ajax", "target": "/ag_op/ajax",          "relation": "urn:lic:graph:rel:farming_operation"},
    { "source": "/party/org/land_corp_aoraki", "target": "/ag_op/aoraki",          "relation": "urn:lic:graph:rel:farming_operation"},
    { "source": "/ag_op/ajax",     "target": "/ag/ajax",             "relation": "urn:lic:graph:rel:animal_mgmt"},
    { "source": "/ag_op/aoraki",     "target": "/ag/aoraki",             "relation": "urn:lic:graph:rel:animal_mgmt"}
  ]
}

# The Farm Management Subscription maintains the capabilities that allow subjects to manage the
# structure of the "Tenant". For example, adds/moves/changes to organisations, people, billing, ag_ops
# and animal groups.  These capabilities are fundemantally associated with managing the graph.
# This is a "closed" eco-system of resources; the graph can be extended but not thru the addition of
# resources outside this closed group.
# This is also the base subscription; it is a priori to the use of all other subscriptions.  That is,
# this is needed to manage the additon of other subscriptions, the management of people and other
# organisational resources.
FARM_MANAGEMENT_SUBSCRIPTION = {
  id:             "1",
  name:           "Farm Organisation Management",
  type:           "urn:lic:sub:farm_org_mgmt",
  capabilities: [
    "urn:lic:sub:farm_org_mgmt:cap:*",
    "urn:lic:sub:farm_org_mgmt:cap:manage_tenant",
    "urn:lic:sub:farm_org_mgmt:cap:view_struct",
    "urn:lic:sub:farm_org_mgmt:cap:manage_subscriptions",
    "urn:lic:sub:farm_org_mgmt:cap:manage_billing"
  ],
  billing_entity: "/billing_entity/land_corp_holding",
  owning_party:   "/party/org/land_corp_holding",
  resources: {
    orgs:             ["/party/org/land_corp_holding", "/party/org/land_corp_ajax", "/party/org/land_corp_aoraki"],
    people:           ["/party/person/a", "/party/person/b", "/party/person/c"],
    ag_ops:           ["/ag_op/ajax", "/ag_op/aoraki"],
    animal_groups:    ["/ag/ajax", "/ag/aoraki"],
    billing_entities: ["/billing_entity/land_corp_holding"]
  },
  subjects: ["/subject/1", "/subject/2", "/subject/3"]
}

# The AgriMetrics Subscription supports the collection of AgOps and Animal Groups that participate
# in AgriMetrics.  This subscription is used to support metrics visualisations.
# Adding AgOps/Animal Groups to the subscription is done via the
# Farm Organisation Management subscription, which commits the owning_party to additional costs
# It highlights that the aggregaton of metrics is across ag_op/1 and ag_op/2 and the associated animal
# groups
AGRIMETRICS_SUBSCRIPTION = {
  id:                 "2",
  name:               "AgriMetrics",
  type:               "urn:lic:sub:agri_metrics",
  capabilities: [
    "urn:lic:sub:agri_metrics:cap:pasture_metrics",
    "urn:lic:sub:agri_metrics:cap:animal_movements"
  ],
  billing_entity:     "/billing_entity/land_corp_holding",
  owning_party:       "/party/org/land_corp_holding",
  resources: {
    orgs:             ["/party/org/land_corp_holding", "/party/org/land_corp_ajax", "/party/org/land_corp_aoraki"],
    people:           ["/party/person/a"],
    ag_ops:           ["/ag_op/ajax", "/ag_op/aoraki"],
    animal_groups:    ["/ag/ajax", "/ag/aoraki"],
    billing_entities: ["/billing_entity/land_corp_holding"]
  },
  subjects:           ["/subject/1"]
}
