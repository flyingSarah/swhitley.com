//import processing.sound.*;

class AmpFollower
{
  //AudioIn in;
  //Amplitude rms;
  var analyser;
  var context;
  var sourceNode;
  var audioBuffer;
  
  boolean error = false;
  boolean audioFound = false;
  float scale = 15;
  float smoothFactor = 0.25;
  
  AmpFollower() //(PApplet applet)
  {
    if(!window.AudioContext)
    {
      if(!window.webkitAudioContext)
      {
        error = true;
        console.log("ERROR: No Audio Context Found!");
      }
      else
      {
        window.AudioContext = window.webkitAudioContext;
      }
    }
    
    context = new AudioContext();
    analyser = context.createAnalyser();
    analyser.smoothingTimeConstant = smoothFactor;
    analyser.fttSize = 512;
    
    sourceNode = context.createBufferSource();

    loadSound("./../sounds/screetchySample.mp3");
    //in = new AudioIn(applet,0);
    //in.start();
    //rms = new Amplitude(applet);
    //rms.input(in);
  }
    
  function loadSound(url)
  {
    var request = new XMLHttpRequest();
    request.open('GET', url, true);
    request.responseType = 'arraybuffer';
    
    //when loaded, decode the data
    request.onload = function() {
      context.decodeAudioData(request.response, callback, errorCallback);
      sourceNode.connect(analyser);
      audioFound = true;
    }
    request.send();
  }
  
  /*function promisifiedOldGUM(constraints)
  {
    var getUserMedia = (navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);
    
    if(!getUserMedia)
    {
      error = true;
      return Promise.reject(new Error("ERROR: Get user media is not supported on this browser!"));
    }
    
    return new Promise(function(resolve, reject)
    {
      getUserMedia.call(navigator, constraints, resolve, reject);
    });
  }*/
  
  function callback(buffer)
  {
    sourceNode.buffer = buffer;
    playSound();
  }
  
  void playSound()
  {
    if(sourceNode.noteOn)
    {
      sourceNode.noteOn(0);
    }
    else
    {
      sourceNode.start(0);
    }
    sourceNode.loop = true;
  }
  
  function errorCallback(error)
  {
    console.log("ERROR: " + error.name);
    error = true;
  }
  
  boolean isAudioReady()
  {
    return (!error && audioFound);
  }
  
  float getAmp()
  {
    //sum += (rms.analyze() - sum) * smoothFactor;
    //float rmsScaled = sum * scale;
    //return rmsScaled;
    var array = new Uint8Array(analyser.frequencyBinCount);
    analyser.getByteFrequencyData(array);
    var average = getAverageVolume(array);
    var scaledAverage = average / (scale);
    return scaledAverage;
  }
  
  function getAverageVolume(array)
  {
    var values = 0;
    var average;
    
    //get all freq amplitudes
    for(var i = 0; i < array.length; i++)
    {
      values += array[i];
    }
    
    average = values/array.length;
    return average;
  }
}