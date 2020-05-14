% < Huffman Tree ���� ��� >
% �� ��带 �󵵼� ��� �������� �����Ѵ�.
% �� ���� �󵵼��� ���� �� ��带 ���� �ϳ��� ���� ��带 �����Ѵ�.
% �� ������ ���� ����� �󵵼��� ���� �� ����� ������ �����Ѵ�.
% �� ��� ��尡 ����� ������ ��~���� �ݺ��Ѵ�.
% �� �Ѹ� ��忡������ �� ������ ������ ������ ���� ��忡 0, 1�� �߰��Ѵ�.

function [codeFinal] = huffman(p)
    AllNode = length(p) * 2 - 1;
    % N���� Node�� ��������� Huffman Tree�� Node ���� 2N-1���̴�.
    Node = cell(AllNode, 1);
    
    for i = 1 : length(p) % �Է°��� ��忡 ����
        Node{i} = [p(i) i 0 0 1];
      % Node{i} = [Ȯ�� ��ȣ �����ڽ� �������ڽ� ����]
    end
    
    for i = length(p) + 1 : AllNode % ���� ��尡 �� ��� ����
        Node{i} = [0 i 0 0 1];
    end
    
    createNode = length(p) + 1;
    lastNode = length(p);
    while createNode ~= AllNode + 2 % ��
        
        %------------- �� Ȯ���� ���� �������� ����-------------------
        for i = 1 : AllNode - 1
            for j = i+1 : AllNode
                % Tree ���̰� ���� Node�� ������
                if (Node{i}(1) == Node{j}(1)) && (Node{i}(1) ~= 0)
                    if Node{i}(5) < Node{j}(5) 
                       temp = Node{j};
                       Node{j} = Node{i};
                       Node{i} = temp;     
                    end
                % Ȯ���� ū Node�� ������
                elseif Node{i}(1) < Node{j}(1)
                    temp = Node{j};
                    Node{j} = Node{i};
                    Node{i} = temp;
                end
            end
        end
        %-----------------------------------------------------------
        
        if lastNode ~= 1
        %--------------- �� ���� ���� ����� ------------------------------
        Node{createNode}(1) = Node{lastNode}(1) + Node{lastNode - 1}(1); % ��
        Node{createNode}(3) = Node{lastNode - 1}(2);
        Node{createNode}(4) = Node{lastNode}(2);
        
        if Node{lastNode}(5) > Node{lastNode - 1}(5) % Tree ���� ����
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
    
    
    %-------------��ȣ ������ �������� ����----------
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
    
    %Tree ������ ���� ������ �Ʒ��� �ڵ带 �Է�
    for i = 1 : AllNode
       Node{i}
    end
    
    code = cell(1, AllNode);
    for i = 1 : AllNode
        code{1, i} = '';
    end
    
    
    %---------------------�� �ڽ� ��忡 0�� 1�� ����------------------------------
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