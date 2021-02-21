function f=color_histogram(im,Nbin)

f=[];
for ch=1:3
    isto=imhist(im(:,ch),Nbin);
    isto=isto./sum(isto);
    f=[f isto'];
end