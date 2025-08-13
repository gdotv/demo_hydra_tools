module Hydra.Ext.Demos.GenPG.Generated.GraphSchema where

import Hydra.Ext.Dsl.Pg.Schemas (propertyType, required, schema, simpleEdgeType, vertexType)
import Hydra.Dsl.Types (binary, boolean, float32, float64, int32, int64, string)

dateType = string
timeType = string

-- Vertex labels -----------------------

ownerVertexLabel = "Owner"
petVertexLabel = "Pet"
appointmentVertexLabel = "Appointment"

-- Edge labels -------------------------

ownsEdgeLabel = "owns"
hasAppointmentEdgeLabel = "hasAppointment"
involvesPetEdgeLabel = "involvesPet"
friendsWithEdgeLabel = "friendsWith"
foughtWithEdgeLabel = "foughtWith"

-- Graph Schema ------------------------

petGraphSchema = schema vertexTypes edgeTypes
  where
    vertexTypes = [
      vertexType ownerVertexLabel int32 [
        required $ propertyType "name" string,
        propertyType "email" string,
        propertyType "afraidOf" string],

      vertexType petVertexLabel int32 [
        required $ propertyType "name" string,
        required $ propertyType "animalType" string],

      vertexType appointmentVertexLabel int32 [
        required $ propertyType "day" string,
        required $ propertyType "time" string,
        propertyType "reasonForAppointment" string]]

    edgeTypes = [
      simpleEdgeType ownsEdgeLabel ownerVertexLabel petVertexLabel [],

      simpleEdgeType hasAppointmentEdgeLabel ownerVertexLabel appointmentVertexLabel [],

      simpleEdgeType involvesPetEdgeLabel appointmentVertexLabel petVertexLabel [],

      simpleEdgeType friendsWithEdgeLabel petVertexLabel petVertexLabel [
        propertyType "bondingActivity" string],

      simpleEdgeType foughtWithEdgeLabel petVertexLabel petVertexLabel [
        required $ propertyType "fightDate" dateType,
        required $ propertyType "fightTime" timeType,
        propertyType "reasonForFight" string,
        propertyType "winner" string]]