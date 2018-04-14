require './lib/fn.rb'

# This is our "Tenant" Structure
# See ./images/neo_test_graph_1.png for a view of the graph
organisational_graph = {
  nodes: [
    { type: "organisation", resource: "/party/org/1" },
    { type: "organisation", resource: "/party/org/2" },
    { type: "organisation", resource: "/party/org/3" },
    { type: "person", resource: "/party/person/a" },
    { type: "person", resource: "/party/person/b" },
    { type: "person", resource: "/party/person/c" },
    { type: "billing_entity", resource: "/billing_entity/1" },
    { type: "ag_op", resource: "/ag_op/1" },
    { type: "ag_op", resource: "/ag_op/2" },
    { type: "animal_group", resource: "/ag/1" },
    { type: "animal_group", resource: "/ag/2" }
  ],
  edges: [
    { "source": "/party/org/1", "target": "/party/org/2", "relation": "urn:lic:graph:rel:holding"},
    { "source": "/party/org/1", "target": "/party/org/3", "relation": "urn:lic:graph:rel:holding"},
    { "source": "/party/org/1", "target": "/party/person/1", "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/2", "target": "/party/person/2", "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/3", "target": "/party/person/3", "relation": "urn:lic:graph:rel:member"},
    { "source": "/party/org/1", "target": "/billing_entity/1", "relation": "urn:lic:graph:rel:financial_acct"},
    { "source": "/party/org/2", "target": "/ag_op/1", "relation": "urn:lic:graph:rel:farming_operation"},
    { "source": "/party/org/3", "target": "/ag_op/2", "relation": "urn:lic:graph:rel:farming_operation"},
    { "source": "/ag_op/1", "target": "/ag/1", "relation": "urn:lic:graph:rel:animal_mgmt"},
    { "source": "/ag_op/2", "target": "/ag/2", "relation": "urn:lic:graph:rel:animal_mgmt"}
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
farm_mgmt_subscription = {
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
  billing_entity: "/billing_entity/1",
  owning_party:   "/party/org/1",
  resources: {
    orgs:             ["/party/org/1", "/party/org/2", "/party/org/3"],
    people:           ["/party/person/a", "/party/person/b", "/party/person/c"],
    ag_ops:           ["/ag_op/1", "/ag_op/2"],
    animal_groups:    ["/ag/1", "/ag/2"],
    billing_entities: ["/billing_entity/1"]
  },
  subjects: ["/subject/1", "/subject/2", "/subject/3"]
}

# The AgriMetrics Subscription supports the collection of AgOps and Animal Groups that participate
# in AgriMetrics.  This subscription is used to support metrics visualisations.
# Adding AgOps/Animal Groups to the subscription is done via the
# Farm Organisation Management subscription, which will commit the owning_party to additional costs
# It highlights that the aggregaton of metrics is across ag_op/1 and ag_op/2 and the associated animal
# groups
agrimetrics_subscription = {
  id:             "2",
  name:           "AgriMetrics",
  type:           "urn:lic:sub:agri_metrics",
  capabilities: [
    "urn:lic:sub:agri_metrics:cap:pasture_metrics",
    "urn:lic:sub:agri_metrics:cap:animal_movements",
  ],
  billing_entity: "/billing_entity/1",
  owning_party:   "/party/org/1",
  resources: {
    orgs:             ["/party/org/1", "/party/org/2", "/party/org/3"],
    people:           ["/party/person/a"],
    ag_ops:           ["/ag_op/1", "/ag_op/2"],
    animal_groups:    ["/ag/1", "/ag/2"],
    billing_entities: ["/billing_entity/1"]
  },
  subjects: ["/subject/1"]
}
