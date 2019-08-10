function tracing_time_comparing(N)


%%% generate number n*n
 myplot1 = zeros(3,N);
 myplot2 = zeros(3,N);
 myplot3 = zeros(3,N);
 myplot4 = zeros(3,N);

x = [1:N];
x_int = [1:0.01:N];

for i = 1:floor(N)
    I = generate(i);
    % part one
    tic
    I2 = left_up_optimum_area_QHT(I,1,1,i,1,i,i,1,i);
    temp = toc;;
     myplot1(1,i) = temp;

    tic
    I2 = left_up_optimum_area_RHT(I,1,1,i,1,i,i,1,i);
    temp = toc;;
     myplot1(2,i) = temp;

    tic
    I2 = left_up_optimum_area_THT(I,1,1,i,1,i,i,1,i);
    temp = toc;
    myplot1(3,i) = temp;


    %part 2
    
        tic
    I2 = right_up_optimum_area_QHT(I,1,1,i,1,i,i,1,i);
    temp = toc;
     myplot2(1,i) = temp;

    tic
    I2 = right_up_optimum_area_RHT(I,1,1,i,1,i,i,1,i);
    temp = toc;
     myplot2(2,i) = temp;

    tic
    I2 = right_up_optimum_area_THT(I,1,1,i,1,i,i,1,i);
    temp = toc;
    myplot2(3,i) = temp;
    
    
    %part 3 
    tic
    I2 = left_down_optimum_area_QHT(I,1,1,i,1,i,i,1,i);
    temp = toc;
     myplot3(1,i) = temp;

    tic
    I2 = left_down_optimum_area_RHT(I,1,1,i,1,i,i,1,i);
    temp = toc;
     myplot3(2,i) = temp;

    tic
    I2 = left_down_optimum_area_THT(I,1,1,i,1,i,i,1,i);
    temp = toc;
    myplot3(3,i) = temp;
    
    
    %part 4 
    
        tic
    I2 = right_down_optimum_area_QHT(I,1,1,i,1,i,i,1,i);
    temp = toc;
     myplot4(1,i) = temp;

    tic
    I2 = right_down_optimum_area_RHT(I,1,1,i,1,i,i,1,i);
    temp = toc;
     myplot4(2,i) = temp;

    tic
    I2 = right_down_optimum_area_THT(I,1,1,i,1,i,i,1,i);
    temp = toc;
    myplot4(3,i) = temp;
    
    
end

    lr_qht = pchip(x,myplot1(1,:),x_int);
    lr_rht = pchip(x,myplot1(2,:),x_int);
    lr_tht = pchip(x,myplot1(3,:),x_int);
    
    subplot(2,1,1);
    hold on
    plot(x_int, lr_qht, 'r'); 
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing left up');
    legend('lu-qht','lu-rht','lu-tht');
    
    subplot(2,1,2);
    hold on
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing left up');
    legend('lu-rht','lu-tht');

    
    figure
    lr_qht = pchip(x,myplot2(1,:),x_int);
    lr_rht = pchip(x,myplot2(2,:),x_int);
    lr_tht = pchip(x,myplot2(3,:),x_int);

    subplot(2,1,1);
    hold on
    plot(x_int, lr_qht, 'r');
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing right up');
    legend('ru-qht','ru-rht','ru-tht');
    
    
        subplot(2,1,2);
    hold on
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing right up');
    legend('ru-rht','ru-tht');
    
    

    figure
    lr_qht = pchip(x,myplot3(1,:),x_int);
    lr_rht = pchip(x,myplot3(2,:),x_int);
    lr_tht = pchip(x,myplot3(3,:),x_int);

    subplot(2,1,1);
    hold on
    plot(x_int, lr_qht, 'r');
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing left down');
    legend('ld-qht','ld-rht','ld-tht');


    subplot(2,1,2);
    hold on
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing left down');
    legend('ld-rht','ld-tht');

    
    figure
       lr_qht = pchip(x,myplot4(1,:),x_int);
    lr_rht = pchip(x,myplot4(2,:),x_int);
    lr_tht = pchip(x,myplot4(3,:),x_int);
    
    subplot(2,1,1);
    hold on
    plot(x_int, lr_qht, 'r');
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing right down');

    legend('rd-qht','rd-rht','rd-tht');


    subplot(2,1,2);
    hold on
    plot(x_int, lr_rht, 'g');
    plot(x_int, lr_tht, 'b');
    title('Time  comparing right down');

    legend('rd-rht','rd-tht');






%%% memory calculus
[user, sys] = memory;
 I2 = left_down_optimum_area_QHT(I,1,1,i,1,i,i,1,i);

[user2, sys2] = memory;

memory_used_in_bytes = user2.MemAvailableAllArrays- user.MemAvailableAllArrays;

disp('memory');
disp(memory_used_in_bytes);

end
