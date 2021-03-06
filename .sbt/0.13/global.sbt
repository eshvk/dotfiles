resolvers ++= Seq(
  Resolver.sonatypeRepo("public"),
  Resolver.typesafeRepo("releases"),
  "Local Maven Repository" at "file://" + Path.userHome.absolutePath + "/.m2/repository",
  "Artifactory" at "https://artifactory.spotify.net/artifactory/repo"
)

net.virtualvoid.sbt.graph.Plugin.graphSettings
