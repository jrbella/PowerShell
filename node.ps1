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

    #gets next node
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
}

<#Test Case
    Expects each insrted value in reverse
    this is a precurser to a stack
#>
$ll = [LinkedList]::new(5)
$ll.insert_beginning(70)
$ll.insert_beginning(5675)
$ll.insert_beginning(90)
$ll.stringify_list()