function [image] = myCheckerboard()
image = zeros(256,256);
black = zeros(16,16);
white = ones(16,16);
count1 = 1;
iCount1 = 1;
count2 = 1;
iCount2 = 1;

while count1<256,
    
   while count2<256,

       if mod(iCount2,2) == 0
           for k=count1:(count1 +16),
               for l=count2:(count2+16),
                   image(k,l) = 1;
               end
           end
       end
       count2 = iCount2*16;
       iCount2 = iCount2 + 1;
   end
   
   count1 = iCount1*16;
   iCount1 = iCount1 + 1;
end

