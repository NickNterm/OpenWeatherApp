/*
  0 	        Clear sky
  1, 2, 3 	  Mainly clear, partly cloudy, and overcast
  45, 48 	    Fog and depositing rime fog
  51, 53, 55 	Drizzle: Light, moderate, and dense intensity
  56, 57 	    Freezing Drizzle: Light and dense intensity
  61, 63, 65 	Rain: Slight, moderate and heavy intensity
  66, 67 	    Freezing Rain: Light and heavy intensity
  71, 73, 75 	Snow fall: Slight, moderate, and heavy intensity
  77 	        Snow grains
  80, 81, 82 	Rain showers: Slight, moderate, and violent
  85, 86 	    Snow showers slight and heavy
  95  	      Thunderstorm: Slight or moderate
  96, 99  	  Thunderstorm with slight and heavy hail
*/

String getWeatherDescriptionFromWeatherCode(int weatherCode) {
  switch (weatherCode) {
    case 0:
      return "Clear sky";
    case 1:
      return "Mainly clear";
    case 2:
      return "Partly cloudy";
    case 3:
      return "Overcast";
    case 45:
      return "Fog";
    case 48:
      return "Fog";
    case 51:
      return "Light drizzle";
    case 53:
      return "Moderate drizzle";
    case 55:
      return "Intence Drizzle";
    case 56:
      return "Light freezing drizzle";
    case 57:
      return "Dense freezing drizzle";
    case 61:
      return "Slight rain";
    case 63:
      return "Moderate rain";
    case 65:
      return "Heavy rain";
    case 66:
      return "Light freezing rain";
    case 67:
      return "Heavy freezing rain";
    case 71:
      return "Slight snow fall";
    case 73:
      return "Moderate snow fall";
    case 75:
      return "Heavy snow fall";
    case 77:
      return "Snow grains";
    case 80:
      return "Slight rain showers";
    case 81:
      return "Moderate rain showers";
    case 82:
      return "Violent rain showers";
    case 85:
      return "Slight snow showers";
    case 86:
      return "Heavy snow showers";
    case 95:
      return "Thunderstorm";
    case 96:
      return "Thunderstorm";
    case 93:
      return "Thunderstorm";
  }
  return "";
}

String getAssetNameFromWeatherCode(int weatherCode) {
  switch (weatherCode) {
    case 0:
      return "sun.svg";
    case 1:
      return "cloud.svg";
    case 2:
      return "cloud.svg";
    case 3:
      return "cloud.svg";
    case 45:
      return "fog.svg";
    case 48:
      return "fog.svg";
    case 51:
      return "drizzle.svg";
    case 53:
      return "drizzle.svg";
    case 55:
      return "drizzle.svg";
    case 56:
      return "drizzle.svg";
    case 57:
      return "drizzle.svg";
    case 61:
      return "rain.svg";
    case 63:
      return "rain.svg";
    case 65:
      return "rain.svg";
    case 66:
      return "rain.svg";
    case 67:
      return "rain.svg";
    case 71:
      return "snow.svg";
    case 73:
      return "snow.svg";
    case 75:
      return "snow.svg";
    case 77:
      return "snow.svg";
    case 80:
      return "snow.svg";
    case 81:
      return "rain.svg";
    case 82:
      return "rain.svg";
    case 85:
      return "snow.svg";
    case 86:
      return "snow.svg";
    case 95:
      return "lightning-rain.svg";
    case 96:
      return "lightning-rain.svg";
    case 93:
      return "lightning-rain.svg";
  }
  return "";
}
