class Node{

    [string]$value
    [Node]$next_node

    #PowerShell constructor
    Node($value){
        $this.value = $value
    }

    #Native Data
    [string]get_value(){
        return $this.value
    }

    #Setting node
    set_next_node([Node]$next_node){
        $this.next_node = [Node]$next_node
    }

    #Gets next node
    [Node]get_next_node($next_node){
        return $next_node.value
    }
}

class LinkedList{

    $head_node = $null

    LinkedList($value){
        $this.head_node = [Node]::new($value)
    }

    [Node]get_head_node(){
        return $this.head_node
    }

    insert_beginning($new_value){
        $new_node = [Node]::new($new_value)
        $new_node.set_next_node($this.head_node)
        $this.head_node = $new_node
    }

    [string]stringify_list(){
        $string_list = ""
        $current_node = $this.get_head_node()
        
        #need to run a loop over the nodes to build the linked list
        while($current_node){
            if ($null -ne $current_node.get_value()){
                $string_list += [string]($current_node.get_value()) + "`n"
                $current_node = $current_node.get_next_node()
            }
        }
        return $string_list
    }

    remove_node($value_to_remove){
        $current_node = $this.head_node

        #Points the head node to the next node if the head node is removed
        if($this.head_node -eq $value_to_remove){
            $this.head_node = ($this.head_node).get_next_node()
        }
        <#
            Tricky, so if we have node (a) -> (b) -> (c) and we need to 
            remove b we need to set (a) next node to c
        #>
        else{

            while($current_node){
                $next_node = $current_node.get_next_node()
                if($next_node.get_value() -eq $value_to_remove){
                    $current_node.set_next_node($next_node.get_next_node())
                    $current_node = $null
                }
                else{
                    $current_node = $next_node
                }

            }
        }
    }
}


Class Stack{

    [Node]$top_item = $null

    Stack($top_item){
        $this.top_item = $top_item
    }

    [Node]peek(){
        return $this.top_item.get_value()
    }

    push($value){
        $item = Node($value)
        $item.set_next_node($this.top_item)
        $this.top_item = $item
    }


    #double check return value might be a [Node]?
    [String]pop(){
        $item_to_remove = $this.top_item
        $this.top_item.set_next_node($item_to_remove.get_next_node())
        return $item_to_remove.get_value()
    }
}
<#Test Case
    Expects each inserted value in reverse
    this is a precurser to a stack
#>
$ll = [LinkedList]::new(5)
$ll.insert_beginning(70)
$ll.insert_beginning(5675)
$ll.insert_beginning(90)
$ll.stringify_list()