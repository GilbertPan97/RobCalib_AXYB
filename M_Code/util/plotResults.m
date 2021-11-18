function plotResults(error_1, error_2 ,error_3 , error_4, point, opt)
%%
if strcmp(opt, 'boxplot')
    
    error_1_perm = permute(error_1, [3, 1, 2]);
    error_2_perm = permute(error_2, [3, 1, 2]);
    
    for i = 1: size(error_1_perm, 3)
        figure
        boxplot(error_1_perm(:,:,i), point);
    end

    for i = 1: size(error_2_perm, 3)
        figure

    end 
    
elseif strcmp(opt, 'lineplot')
    
    Err1_Avg = sum(error_1, 3)/size(error_1, 3);
    Err2_Avg = sum(error_2, 3)/size(error_2, 3);
    Err3_Avg = sum(error_3, 3)/size(error_3, 3);
    Err4_Avg = sum(error_4, 3)/size(error_4, 3);
    
    figure
    plot(point, Err1_Avg(:,1),'b-o')
    hold on
    plot(point, Err2_Avg(:,1),'r-*')
    hold on
    plot(point, Err3_Avg(:,1),'g-+')
    hold on
    plot(point, Err4_Avg(:,1),'k-.')
    xlabel('Noise Level');
    yl1 = ylabel('$\bf E_{R_{X}}$');
    set(yl1,'FontSize',14,'Interpreter','latex');
    len1 = legend('$Prob1$','$Prob2$','Wang','$DQ$');
    set(len1,'FontSize',14,'Interpreter','latex');
    
    figure
    plot(point, Err1_Avg(:,2),'b-o')
    hold on
    plot(point, Err2_Avg(:,2),'r-*')
    hold on
    plot(point, Err3_Avg(:,2),'g-+')
    hold on
    plot(point, Err4_Avg(:,2),'k-.')
    xlabel('Noise Level');
    yl2 = ylabel('$\bf E_{R_{Y}}$');
    set(yl2,'FontSize',14,'Interpreter','latex');
    len2 = legend('$Prob1$','$Prob2$','$Wang$','$DQ$');
    set(len2,'FontSize',14,'Interpreter','latex');
    
    figure
    plot(point, Err1_Avg(:,3),'b-o')
    hold on
    plot(point, Err2_Avg(:,3),'r-*')
    hold on
    plot(point, Err3_Avg(:,3),'g-+')
    hold on
    plot(point, Err4_Avg(:,3),'k-.')
    xlabel('Noise Level');
    yl3 = ylabel('$\bf E_{R_{Z}}$');
    set(yl3,'FontSize',14,'Interpreter','latex');
    len3 = legend('$Prob1$','$Prob2$','Wang','$DQ$');
    set(len3,'FontSize',14,'Interpreter','latex');
    
    
    figure
    plot(point, Err1_Avg(:,4),'b-o')
    hold on
    plot(point, Err2_Avg(:,4),'r-*')
    hold on
    plot(point, Err3_Avg(:,4),'g-+')
    hold on
    plot(point, Err4_Avg(:,4),'k-.')
    xlabel('Noise Level');
    yl4 = ylabel('$\bf E_{t_{X}}$');
    set(yl4,'FontSize',14,'Interpreter','latex');
    len4 = legend('$Prob1$','$Prob2$','Wang','$DQ$');
    set(len4,'FontSize',12,'Interpreter','latex');
    
    figure
    plot(point, Err1_Avg(:,5),'b-o')
    hold on
    plot(point, Err2_Avg(:,5),'r-*')
    hold on
    plot(point, Err3_Avg(:,5),'g-+')
    hold on
    plot(point, Err4_Avg(:,5),'k-.')
    xlabel('Noise Level');
    yl5= ylabel('$\bf E_{t_{Y}}$');
    set(yl5,'FontSize',14,'Interpreter','latex');
    len5 = legend('$Prob1$','$Prob2$','Wang','$DQ$');
    set(len5,'FontSize',14,'Interpreter','latex');
    
    figure
    plot(point, Err1_Avg(:,6),'b-o')
    hold on
    plot(point, Err2_Avg(:,6),'r-*')
    hold on
    plot(point, Err3_Avg(:,6),'g-+')
    hold on
    plot(point, Err4_Avg(:,6),'k-.')
    xlabel('Noise Level');
    yl6 = ylabel('$\bf E_{t_{Z}}$');
    set(yl6,'FontSize',14,'Interpreter','latex');
    len6 = legend('$Prob1$','$Prob2$','Wang','$DQ$');
    set(len6,'FontSize',12,'Interpreter','latex');
    
end

end