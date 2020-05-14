% < Huffman Tree 생성 방식 >
% ① 노드를 빈도수 대로 내림차순 정렬한다.
% ② 가장 빈도수가 낮은 두 노드를 합쳐 하나의 상위 노드를 생성한다.
% ③ 생성된 상위 노드의 빈도수는 하위 두 노드의 합으로 결정한다.
% ④ 모든 노드가 연결될 때까지 ①~③을 반복한다.
% ⑤ 뿌리 노드에서부터 잎 노드까지 갈라질 때마다 양쪽 노드에 0, 1을 추가한다.

function [codeFinal] = huffman(p)
    AllNode = length(p) * 2 - 1;
    % N개의 Node로 만들어지는 Huffman Tree의 Node 수는 2N-1개이다.
    Node = cell(AllNode, 1);
    
    for i = 1 : length(p) % 입력값을 노드에 저장
        Node{i} = [p(i) i 0 0 1];
      % Node{i} = [확률 번호 왼쪽자식 오른쪽자식 높이]
    end
    
    for i = length(p) + 1 : AllNode % 상위 노드가 될 노드 생성
        Node{i} = [0 i 0 0 1];
    end
    
    createNode = length(p) + 1;
    lastNode = length(p);
    while createNode ~= AllNode + 2 % ④
        
        %------------- ① 확률에 대해 내림차순 정렬-------------------
        for i = 1 : AllNode - 1
            for j = i+1 : AllNode
                % Tree 높이가 높은 Node를 앞으로
                if (Node{i}(1) == Node{j}(1)) && (Node{i}(1) ~= 0)
                    if Node{i}(5) < Node{j}(5) 
                       temp = Node{j};
                       Node{j} = Node{i};
                       Node{i} = temp;     
                    end
                % 확률이 큰 Node를 앞으로
                elseif Node{i}(1) < Node{j}(1)
                    temp = Node{j};
                    Node{j} = Node{i};
                    Node{i} = temp;
                end
            end
        end
        %-----------------------------------------------------------
        
        if lastNode ~= 1
        %--------------- ② 상위 가지 만들기 ------------------------------
        Node{createNode}(1) = Node{lastNode}(1) + Node{lastNode - 1}(1); % ③
        Node{createNode}(3) = Node{lastNode - 1}(2);
        Node{createNode}(4) = Node{lastNode}(2);
        
        if Node{lastNode}(5) > Node{lastNode - 1}(5) % Tree 높이 설정
           Node{createNode}(5) = Node{lastNode}(5) + 1;
        else
            Node{createNode}(5) = Node{lastNode - 1}(5) + 1;
        end
        
        Node{lastNode}(1) = 0;
        Node{lastNode - 1}(1) = 0;
        %-----------------------------------------------------------------
        lastNode = lastNode - 1;
        end
        createNode = createNode + 1;
    end
    
    
    %-------------번호 순으로 내림차순 정렬----------
    for i = 1 : AllNode - 1
        for j = i : AllNode
            if Node{i}(2) < Node{j}(2)
                temp = Node{j};
                Node{j} = Node{i};
                Node{i} = temp;
            end
        end
    end
    %-----------------------------------------------
    
    %Tree 구조를 보고 싶으면 아래의 코드를 입력
    for i = 1 : AllNode
       Node{i}
    end
    
    code = cell(1, AllNode);
    for i = 1 : AllNode
        code{1, i} = '';
    end
    
    
    %---------------------⑤ 자식 노드에 0과 1을 붙임------------------------------
    for i = 1 : AllNode
        if Node{i}(3) ~= 0
            code{1,Node{i}(3)} = strcat(code{1,Node{i}(3)}, code{1,Node{i}(2)});
            code{1,Node{i}(4)} = strcat(code{1,Node{i}(4)}, code{1,Node{i}(2)});
            code{1,Node{i}(3)} = strcat(code{1,Node{i}(3)}, '0');
            code{1,Node{i}(4)} = strcat(code{1,Node{i}(4)}, '1');
        end
    end
    %----------------------------------------------------------------------------
    
    
    codeFinal = cell(1, length(p));
    for i = 1 : length(p)
        codeFinal{1, i} = code{1, i};
    end    
end