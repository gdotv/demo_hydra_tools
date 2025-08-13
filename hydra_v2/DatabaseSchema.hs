module Hydra.Ext.Demos.GenPG.Generated.DatabaseSchema where

import Hydra.Dsl.Tabular (TableType, tableType, columnType)
import Hydra.Dsl.Types (binary, boolean, float32, float64, int32, int64, string)

ownersTableType :: TableType
ownersTableType = tableType "owners.csv" [
  columnType "owner_id" int32,
  columnType "owner_name" string,
  columnType "email" string,
  columnType "afraid_of" string]

petsTableType :: TableType
petsTableType = tableType "pets.csv" [
  columnType "pet_id" int32,
  columnType "name" string,
  columnType "animal_type" string,
  columnType "owner" string,
  columnType "owner_id" int32]

appointmentsTableType :: TableType
appointmentsTableType = tableType "appointments.csv" [
  columnType "appt_id" int32,
  columnType "owner_id" int32,
  columnType "owner_name" string,
  columnType "pet_id" int32,
  columnType "pet_name" string,
  columnType "day" string,
  columnType "time" string,
  columnType "reason_for_appointment" string]

petFightsTableType :: TableType
petFightsTableType = tableType "pet_fights.csv" [
  columnType "fight_id" int32,
  columnType "pet_id_1" int32,
  columnType "pet_name_1" string,
  columnType "pet_id_2" int32,
  columnType "pet_name_2" string,
  columnType "date" string,
  columnType "time" string,
  columnType "reason_for_fight" string,
  columnType "Winner" string]

petFriendshipsTableType :: TableType
petFriendshipsTableType = tableType "pet_friendships.csv" [
  columnType "friendship_id" int32,
  columnType "pet1_id" int32,
  columnType "pet1_name" string,
  columnType "pet2_id" int32,
  columnType "pet2_name" string,
  columnType "bonding_activity" string]

generatedTableSchemas :: [TableType]
generatedTableSchemas = [
  ownersTableType,
  petsTableType,
  appointmentsTableType,
  petFightsTableType,
  petFriendshipsTableType]