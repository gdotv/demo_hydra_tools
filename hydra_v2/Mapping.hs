module Hydra.Ext.Demos.GenPG.Generated.Mapping where

import Hydra.Core (Term)
import Hydra.Pg.Model (Edge, Vertex)
import Hydra.Formatting (decapitalize)
import Hydra.Phantoms (TTerm)
import Hydra.Dsl.Phantoms ((@@), constant, just, lambda, nothing, string, var)
import Hydra.Ext.Dsl.Pg.Mappings (LazyGraph, column, edge, edgeNoId, graph, property, vertex)
import qualified Hydra.Dsl.Lib.Literals as Literals
import qualified Hydra.Dsl.Lib.Optionals as Optionals
import qualified Hydra.Dsl.Lib.Strings as Strings
import Hydra.Ext.Demos.GenPG.Generated.GraphSchema

-- Helpers -----------------------

labeledIntId :: String -> TTerm (r -> Maybe Int) -> TTerm (r -> String)
labeledIntId itype iid = lambda "r" $ Optionals.map
  (lambda "i" $ Strings.concat [
    string $ decapitalize itype,
    string "_",
    Literals.showInt32 $ var "i"])
  (iid @@ var "r")

labeledStringId :: String -> TTerm (r -> Maybe String) -> TTerm (r -> String)
labeledStringId itype iid = lambda "r" $ Optionals.map
  (lambda "s" $ Strings.concat [
    string $ decapitalize itype,
    string "_",
    var "s"])
  (iid @@ var "r")

-- Mapping -----------------------------

generatedGraphMapping :: LazyGraph Term
generatedGraphMapping = graph
  -- Vertices
  [vertex "owners.csv" ownerVertexLabel (labeledIntId ownerVertexLabel $ column "owner_id") [
     property "name" $ column "owner_name",
     property "email" $ column "email",
     property "afraidOf" $ column "afraid_of"],

   vertex "pets.csv" petVertexLabel (labeledIntId petVertexLabel $ column "pet_id") [
     property "name" $ column "name",
     property "animalType" $ column "animal_type"],

   vertex "pets.csv" speciesVertexLabel (labeledStringId speciesVertexLabel $ column "animal_type") [
     property "type" $ column "animal_type"],

   vertex "appointments.csv" appointmentVertexLabel (labeledIntId appointmentVertexLabel $ column "appt_id") [
     property "day" $ column "day",
     property "time" $ column "time",
     property "reasonForAppointment" $ column "reason_for_appointment"]]

  -- Edges
  [-- Owner owns Pet (needs name-to-ID mapping)
   edgeNoId "pets.csv" ownsEdgeLabel
     (labeledIntId ownerVertexLabel $ column "owner_id")
     (labeledIntId petVertexLabel $ column "pet_id")
     [],

   -- Owner has Appointment
   edgeNoId "appointments.csv" hasAppointmentEdgeLabel
     (labeledIntId ownerVertexLabel $ column "owner_id")
     (labeledIntId appointmentVertexLabel $ column "appt_id")
     [],

   -- Appointment involves Pet (needs name-to-ID mapping)
   edgeNoId "appointments.csv" involvesPetEdgeLabel
     (labeledIntId appointmentVertexLabel $ column "appt_id")
     (labeledIntId petVertexLabel $ column "pet_id")
     [],

   -- Owner is afraid of
   edgeNoId "owners.csv" afraidEdgeLabel
     (labeledIntId ownerVertexLabel $ column "owner_id")
     (labeledStringId speciesVertexLabel $ column "afraid_of")
     [],

   -- Pet is species type
   edgeNoId "pets.csv" speciesEdgeLabel
     (labeledIntId petVertexLabel $ column "pet_id")
     (labeledStringId speciesVertexLabel $ column "animal_type")
     [],

   -- Pet 1 friends with Pet 2
   edgeNoId "pet_friendships.csv" friendsWithEdgeLabel
     (labeledIntId petVertexLabel $ column "pet1_id")
     (labeledIntId petVertexLabel $ column "pet2_id")
     [property "bondingActivity" $ column "bonding_activity"],

   -- Pet 2 friends with Pet 1 (bidirectional friendship)
   edgeNoId "pet_friendships.csv" friendsWithEdgeLabel
     (labeledIntId petVertexLabel $ column "pet2_id")
     (labeledIntId petVertexLabel $ column "pet1_id")
     [property "bondingActivity" $ column "bonding_activity"],

   -- Pet 1 fought with Pet 2
   edgeNoId "pet_fights.csv" foughtWithEdgeLabel
     (labeledIntId petVertexLabel $ column "pet_id_1")
     (labeledIntId petVertexLabel $ column "pet_id_2")
     [property "fightDate" $ column "date",
      property "fightTime" $ column "time",
      property "reasonForFight" $ column "reason_for_fight",
      property "winner" $ column "Winner"],

   -- Pet 2 fought with Pet 1 (bidirectional fight relationship)
   edgeNoId "pet_fights.csv" foughtWithEdgeLabel
     (labeledIntId petVertexLabel $ column "pet_id_2")
     (labeledIntId petVertexLabel $ column "pet_id_1")
     [property "fightDate" $ column "date",
      property "fightTime" $ column "time",
      property "reasonForFight" $ column "reason_for_fight",
      property "winner" $ column "Winner"]]