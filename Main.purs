module Main where

import Prelude

import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Window (requestAnimationFrame)
import Data.Array (replicate, snoc)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.JQuery (addClass, body, create, css, getCss, getPageX, getPageY, off, on, select, setAttr)
import Control.Monad.Eff.JQuery (append) as JQ
import Control.Monad.Eff.Timer (TIMER, setTimeout)
import Control.Monad.ST (ST, STRef, newSTRef, readSTRef, writeSTRef)
import Data.Array.Partial (tail)
import Data.Int (toNumber)
import Math (sqrt)

CubeGenerate :: forall e. Eff (dom :: DOM |e) Unit
CubeGenerate = do
  frontFace <- create "<div>"
  setAttr "id" "ff" frontFace
  addClass "face" frontFace
  backFace <- create "<div>"
  setAttr "id" "bf" backFace
  addClass "face" backFace
  topFace <- create "<div>"
  setAttr "id" "tf" rightFace
  addClass "face" rightFace
  bottomFace <- create "<div>"
  setAttr "id" "bof" leftFace
  addClass "face" leftFace
  leftFace <- create "<div>"
  setAttr "id" "lf" topFace
  addClass "face" topFace
  rightFace <- create "<div>"
  setAttr "id" "rf" bottomFace
  addClass "face" bottomFace
  cube <- create "<div>"
  addClass "cube" cube
  css {backgroundColor: "#ff0000"} frontFace
  css {backgroundColor: "ff0000"} backFace
  css {backgroundColor: "#ff3232"} topFace
  css {backgroundColor: "#ff3232"} bottomFace
  css {backgroundColor: "#ff3232"} rightFace
  css {backgroundColor: "#ff3232"} leftFaces
  css {position: "relative"} cube
  JQ.append frontFace cube
  JQ.append backFace cube
  JQ.append rightFace cube
  JQ.append leftFace cube
  JQ.append topFace cube
  JQ.append bottomFace cube
  cubeWrapper <- create "<div>"
  setAttr "id" "wrapper" cubeWrapper
  css {position : "absolute",
    left : "50%",top : "50%",
    perspective: "1500px"} cubeWrapper
  JQ.append cube cubeWrapper
  body <- body
  JQ.append cubeWrapper body
  css { width: "100%", height: "100%" } body
  face <- select ".face"
  css {position : "absolute",
  	width : "200px",
  	height : "200px"} face
  css { transform: "rotateX(-45deg)rotateY(45deg)"} cube
main :: forall h e. Eff (dom :: DOM, st :: ST h, timer :: TIMER, console :: CONSOLE | e) Unit
main = do
  CubeGenerate
  