function [paths,costs]= kshortestwrap_pred(rs,k)

if k==0
    paths= [];
    costs= [];
    return;
end
  
  ns= length(rs); 
  [ds,is]= sort(rs(:),1,'descend'); %sort weights in decreasing order

  CM= 0*ones(ns,ns); %cost matrix for paths !REMEMBER ZERO COST DENOTES NO ARC CONNECTION I.E. INF COST BECAUSE OF SPARSE MATRIX INPUT FOR KSHORTEST PATH
  %记得零成本表示无弧连接即信息成本因为kshortest路径稀疏矩阵的输入
  for i=1:ns %形成一个上三角矩阵
     CM(1:i-1,i)= ds(i); %only allow jumps to higher numbered nodes, inf costs (equiv to zero cost for sparse representation) on lower diag prohibit reverse jumps (hence cycles)
  end                              %只允许跳到更高编号的节点，信息成本（相当于稀疏表示的零成本）低诊断禁止反向跳跃（因此周期） 
   
  CMPad= 0*ones(ns+2,ns+2); %extra 2 states for start and finish points !REMEMBER ZERO COST DENOTES NO ARC CONNECTION I.E. INF COST BECAUSE OF SPARSE MATRIX INPUT FOR KSHORTEST PATH
                                                   %开始和结束点的额外2种状态！记得零成本表示无弧连接即信息成本因为kshortest路径稀疏矩阵的输入 
  CMPad(1,2:end-1)= ds'; %must enter into one of original nodes OR必须输入原始节点或
  CMPad(1,end)= eps(0); %exit immediately indicating no node selection (all target die) (eps used to denote zero cost or free jumo, as zero is used for inf in sparse format)
                                          %立即退出表示没有节点选择（所有目标模）（EPS用来表示零成本或免费的网站，作为零用于INF稀疏格式） 
  CMPad(2:end-1,end)= eps(0); %must exit at last node at no cost (eps used to denote zero cost or free jump, as zero is used for inf in sparse format)
                                                        %必须在最后一个节点退出，不需要任何费用（EPS用于表示零成本或自由跳转，因为在稀疏格式中用零作为INF） 
  CMPad(2:end-1,2:end-1)= CM; %cost for original nodes原始节点成本 
  
  [paths,costs]= kShortestPath_any(CMPad,1,ns+2,k); %do k-shortest path%计算最短路径
  
  for p=1:length(paths)
      if isequal(paths{p},[1 ns+2])%测试相等数组，就是两个是否相等
          paths{p}= [];  %0 indicates no nodes selected0表示没有选定节点。
      else
          paths{p}= paths{p}(2:end-1)-1; %strip dummy entry and finish nodes带状虚拟入口和完成节点 
          paths{p}= is(paths{p}); %convert index back to unsorted input将指数回到未分类的输入 
      end
  end
 
 