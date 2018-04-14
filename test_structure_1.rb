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


subscription = {
  id:             "1",
  name:           "Farm Organisation Management",
  type:             "urn:lic:sub:farm_org_mgmt",
  capabilities: [
    "urn:lic:sub:farm_org_mgmt:cap:*",
    "urn:lic:sub:farm_org_mgmt:cap:manage_struct",
    "urn:lic:sub:farm_org_mgmt:cap:view_struct",
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
