library("mongolite")
jostein_uri <- "mongodb://admin:KFTZXKMBGIWKMWJK@sl-us-south-1-portal.12.dblayer.com:28046,sl-us-south-1-portal.17.dblayer.com:28046/admin?3t.connection.name=JosteinDB&3t.connectTimeout=10000&3t.uriVersion=2&3t.certificatePreference=RootCACert:accept_any&3t.databases=admin,compose&3t.useClientCertPassword=false&readPreference=primary&ssl=true&3t.socketTimeout=0&3t.sharded=true&3t.connectionMode=multi"
m <- mongo(collection = "NFL", db = "test",  verbose = TRUE, url=jostein_uri, options = ssl_options(weak_cert_validation = T))

# Test query to see if database was imported correctly
testQuery <- m$find(limit = 10)
head(testQuery)

# Returns all plays that scored a touchdown with positive yard gains,
# grouping by team and count the plays per team, sorted in alphabetical order
ydsGainTD <- m$aggregate('[
		{ "$match": { "Yards.Gained": { "$gt": 0 }, "Touchdown": { "$gt": 0 } } },
    { "$group": { "_id": "$posteam" , "count": { "$sum": 1 } } },
    { "$sort": { "_id": 1} }
  ]')

head(ydsGainTD)

# Returns average yards gained and average number of touchdowns per team
avgYdsTds <- m$aggregate('[
  { "$group": {
      "_id": "$posteam",
      "ydsGainAvg": { "$avg": "$Yards.Gained" }, 
      "tdsAvg": { "$avg": "$Touchdown" }
      }
  }]')

head(avgYdsTds)

# Robert's query
# Returns sum of touchdowns and sum of penalty yards per team
sumTdsPenYds <- m$aggregate('[
  { "$group": { 
      "_id": { "posteam": "$posteam"},
      "Touchdown": { "$sum": "$Touchdown" },
      "Penalty_Yards": { "$sum": "$Penalty.Yards" }
    }
  }]')

head(sumTdsPenYds)

# Robert's query
# Returns sum of touchdowns by quarter per team
sumTdsPerQtr <- m$aggregate('[
  { "$group": { 
    "_id": {"Team": "$posteam", "Quarter": "$qtr"},
    "Touchdown": { "$sum": "$Touchdown" }
    }
  }]')

head(sumTdsPerQtr)