clear;
% EJEMPLO DE ALMACENAR LA SECUENCIA DE VIDEO PROCESADA EN UN ARCHIVO AVI clear 
video=videoinput('winvideo',1,'YUY2_320x240'); % 
video.ReturnedColorSpace = 'RGB'; 
video.TriggerRepeat=inf; % disparos continuados 
video.FrameGrabInterval=3;  
set(video, 'LoggingMode', 'memory') 
  
aviobj = VideoWriter('Ejemplo.avi', 'Uncompressed AVI'); % Crear objeto archivo avi 
aviobj.FrameRate = 10; % El video sera a 10 fps open(aviobj) 
 
open(aviobj);
start(video)
while (video.FramesAcquired<100) % Video de 10s 
    I=getdata(video,1); % captura un frame guardado en memoria.  
    imshow(I) 
         
    %writeVideo(aviobj,getframe); % Lo que se muestra en la 
    % ventana de tipo figure, se convierte en frame y se añade al video         
    %aviobj = addframe(aviobj,I); % Se añade directamente el frame         
    writeVideo(aviobj,I); 
end

stop(video) 
close(aviobj);
  
