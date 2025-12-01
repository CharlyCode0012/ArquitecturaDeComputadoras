import tkinter as tk
from tkinter import filedialog, messagebox, scrolledtext
import tkinter.ttk as ttk
from ttkthemes import ThemedTk

# Diccionarios para traducción
OPCODES = {
    'j': '000010', 'jal': '000011', 'beq': '000100', 'bne': '000101',
    'addi': '001000', 'addiu': '001001', 'slti': '001010', 'sltiu': '001011',
    'andi': '001100', 'ori': '001101', 'lui': '001111', 'lw': '100011',
    'sw': '101011', 'add': '000000', 'addu': '000000', 'sub': '000000',
    'and': '000000', 'or': '000000', 'slt': '000000', 'sltu': '000000',
    'sll': '000000', 'srl': '000000', 'jr': '000000'
}

FUNCTS = {
    'add': '100000', 'addu': '100001', 'sub': '100010', 'and': '100100',
    'or': '100101', 'slt': '101010', 'sltu': '101011', 'sll': '000000',
    'srl': '000010', 'jr': '001000'
}

# Diccionario completo de registros MIPS
REGISTERS = {
    # Por número
    '$0': '00000', '$1': '00001', '$2': '00010', '$3': '00011',
    '$4': '00100', '$5': '00101', '$6': '00110', '$7': '00111',
    '$8': '01000', '$9': '01001', '$10': '01010', '$11': '01011',
    '$12': '01100', '$13': '01101', '$14': '01110', '$15': '01111',
    '$16': '10000', '$17': '10001', '$18': '10010', '$19': '10011',
    '$20': '10100', '$21': '10101', '$22': '10110', '$23': '10111',
    '$24': '11000', '$25': '11001', '$26': '11010', '$27': '11011',
    '$28': '11100', '$29': '11101', '$30': '11110', '$31': '11111',
    
    # Por nombre estándar MIPS
    '$zero': '00000', '$at': '00001', '$v0': '00010', '$v1': '00011',
    '$a0': '00100', '$a1': '00101', '$a2': '00110', '$a3': '00111',
    '$t0': '01000', '$t1': '01001', '$t2': '01010', '$t3': '01011',
    '$t4': '01100', '$t5': '01101', '$t6': '01110', '$t7': '01111',
    '$s0': '10000', '$s1': '10001', '$s2': '10010', '$s3': '10011',
    '$s4': '10100', '$s5': '10101', '$s6': '10110', '$s7': '10111',
    '$t8': '11000', '$t9': '11001', '$k0': '11010', '$k1': '11011',
    '$gp': '11100', '$sp': '11101', '$fp': '11110', '$ra': '11111'
}

class MIPSTranslator:
    def __init__(self, root):
        self.root = root
        self.root.title("🚀 Traductor MIPS32 - Assembler")
        self.root.geometry("1000x800")
        self.root.minsize(900, 650)
        
        # Configurar estilo
        self.setup_styles()
        
        # Configuración de la interfaz
        self.create_widgets()
    
    def setup_styles(self):
        style = ttk.Style()
        
        # Configurar tema simple y eficiente
        style.theme_use('clam')  # Tema más rápido y estable
        
        # Paleta de colores simplificada
        self.colors = {
            'primary': '#3498DB',
            'secondary': '#2C3E50',
            'success': '#27AE60',
            'light': '#ECF0F1',
            'dark': '#34495E'
        }
        
        # Configurar estilos básicos
        style.configure('TFrame', background=self.colors['secondary'])
        style.configure('TLabel', background=self.colors['secondary'], foreground=self.colors['light'], font=('Segoe UI', 9))
        style.configure('Title.TLabel', background=self.colors['secondary'], foreground=self.colors['light'], font=('Segoe UI', 14, 'bold'))
        
        # Configurar botones
        style.configure(
            'TButton', 
            font=('Segoe UI', 9, 'bold'), 
            padding=(8, 4),
            background=self.colors['primary'],
            foreground='white'
        )
        
        style.configure(
            'Success.TButton', 
            background=self.colors['success'],
            foreground='white'
        )
        
        style.configure('TEntry', font=('Segoe UI', 9))
        
        # Mapeo simple de estados de botones
        style.map(
            'TButton',
            background=[('active', '#2980B9'), ('pressed', '#2471A3')],
            foreground=[('active', 'white'), ('pressed', 'white')]
        )
        
        style.map(
            'Success.TButton',
            background=[('active', '#229954'), ('pressed', '#1E8449')],
            foreground=[('active', 'white'), ('pressed', 'white')]
        )
    
    def create_widgets(self):
        # Frame principal
        main_frame = ttk.Frame(self.root, padding="15")
        main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Título
        title_label = ttk.Label(main_frame, text="🧠 Traductor de Ensamblador MIPS32", style='Title.TLabel')
        title_label.pack(pady=(0, 15), fill=tk.X)
        
        # Frame para entrada de ensamblador
        input_frame = ttk.LabelFrame(main_frame, text="📝 Código Ensamblador MIPS32", padding="10")
        input_frame.pack(fill=tk.BOTH, expand=True, pady=(0, 10))
        
        # Textarea para ingresar ensamblador
        self.input_text = scrolledtext.ScrolledText(
            input_frame, 
            width=85,
            height=10,
            font=('Consolas', 10),
            bg='#1A1A1A',
            fg='#00FF00',
            insertbackground='white',
            selectbackground=self.colors['primary'],
            wrap=tk.WORD
        )
        self.input_text.pack(fill=tk.BOTH, expand=True)
        
        # Insertar ejemplo con comentarios //
        example_code = """// Ejemplos de instrucciones MIPS32:

// Tipo R - Formato: OP RD, RS, RT
ADD $10, $5, $2
ADDU $8, $9, $10
SUB $11, $12, $13
AND $10, $11, $12
OR $13, $14, $15

// Tipo I - Formato: OP RT, RS, INMEDIATO
ADDI $3, $5, 20
ADDI $3, $5, #20   // Con # también funciona
ADDI $4, $4, -10
ADDI $4, $4, #-10
ORI $4, $6, 255

// Tipo J - Formato: OP DIRECCION
J 0x00400000
JAL 0x00400020

// Load/Store - Formato: OP RT, OFFSET(RS)
LW $2, 100($3)
LW $2, -4($3)
LW $2, #-8($3)
SW $5, 200($4)"""
        self.input_text.insert('1.0', example_code)
        
        # Frame para controles
        controls_frame = ttk.Frame(main_frame)
        controls_frame.pack(fill=tk.X, pady=10)
        
        # Botón de traducción 
        translate_btn = ttk.Button(
            controls_frame, 
            text="🔍 Traducir Código", 
            command=self.translate,
            style='TButton'
        )
        translate_btn.pack(side=tk.LEFT, padx=(0, 10))
        
        # Frame para guardar archivo
        file_frame = ttk.LabelFrame(controls_frame, text="💾 Guardar Resultado", padding="8")
        file_frame.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(20, 0))
        
        ttk.Label(file_frame, text="Archivo:").grid(row=0, column=0, padx=(0, 5), sticky='w')
        self.file_path = ttk.Entry(file_frame, width=40, font=('Segoe UI', 9))
        self.file_path.grid(row=0, column=1, padx=5, sticky='ew')
        
        browse_btn = ttk.Button(
            file_frame, 
            text="📁 Examinar", 
            command=self.browse_file,
            style='TButton'
        )
        browse_btn.grid(row=0, column=2, padx=(5, 10))
        
        save_btn = ttk.Button(
            file_frame, 
            text="💾 Guardar", 
            command=self.save_file,
            style='Success.TButton'
        )
        save_btn.grid(row=0, column=3, padx=5)
        
        file_frame.columnconfigure(1, weight=1)
        
        # Frame para resultado
        output_frame = ttk.LabelFrame(main_frame, text="📊 Resultado - Código Máquina", padding="10")
        output_frame.pack(fill=tk.BOTH, expand=True, pady=(10, 0))
        
        # Área de resultado
        self.output_text = scrolledtext.ScrolledText(
            output_frame, 
            width=85,
            height=10,
            font=('Consolas', 10),
            bg='#1A1A1A',
            fg='#FFD700',
            insertbackground='white',
            selectbackground=self.colors['primary'],
            wrap=tk.WORD
        )
        self.output_text.pack(fill=tk.BOTH, expand=True)
        
        # Frame de información expandida
        info_frame = ttk.LabelFrame(main_frame, text="ℹ️ Información de Instrucciones y Registros MIPS32", padding="8")
        info_frame.pack(fill=tk.X, pady=(15, 0))
        
        # Crear notebook para pestañas
        notebook = ttk.Notebook(info_frame)
        notebook.pack(fill=tk.X, padx=5, pady=5)
        
        # Pestaña de registros
        registers_tab = ttk.Frame(notebook)
        notebook.add(registers_tab, text="Registros")
        
        registers_info = """
Registros por número: $0-$31
Por nombre: 
  $zero (0), $at (1), $v0-$v1 (2-3), $a0-$a3 (4-7)
  $t0-$t7 (8-15), $s0-$s7 (16-23), $t8-$t9 (24-25)
  $k0-$k1 (26-27), $gp (28), $sp (29), $fp (30), $ra (31)
"""
        registers_label = ttk.Label(
            registers_tab, 
            text=registers_info,
            font=('Consolas', 9),
            background='#34495E',
            foreground='#BDC3C7',
            justify=tk.LEFT
        )
        registers_label.pack(fill=tk.X, padx=5, pady=5)
        
        # Pestaña de instrucciones Tipo R
        r_type_tab = ttk.Frame(notebook)
        notebook.add(r_type_tab, text="Tipo R")
        
        r_type_info = """
Formato: OP RD, RS, RT
Ejemplo: ADD $10, $5, $2

OPCODE: 000000 (6 bits)
RS: Registro fuente (5 bits)
RT: Registro origen (5 bits)
RD: Registro destino (5 bits)
SHAMT: Cantidad de desplazamiento (5 bits)
FUNCT: Función (6 bits)

Instrucciones:
  ADD: Suma con signo
  ADDU: Suma sin signo
  SUB: Resta con signo
  AND: AND bit a bit
  OR: OR bit a bit
  SLT: Establecer si menor que (con signo)
  SLTU: Establecer si menor que (sin signo)
  SLL: Desplazamiento lógico a la izquierda
  SRL: Desplazamiento lógico a la derecha
  JR: Salto a registro
"""
        r_type_label = ttk.Label(
            r_type_tab, 
            text=r_type_info,
            font=('Consolas', 9),
            background='#34495E',
            foreground='#BDC3C7',
            justify=tk.LEFT
        )
        r_type_label.pack(fill=tk.BOTH, padx=5, pady=5)
        
        # Pestaña de instrucciones Tipo I
        i_type_tab = ttk.Frame(notebook)
        notebook.add(i_type_tab, text="Tipo I")
        
        i_type_info = """
Formato: OP RT, RS, INMEDIATO
Ejemplo: ADDI $3, $5, 20

OPCODE: Código de operación (6 bits)
RS: Registro fuente (5 bits)
RT: Registro destino (5 bits)
INMEDIATO: Valor inmediato (16 bits)

Instrucciones:
  ADDI: Suma inmediata con signo
  ADDIU: Suma inmediata sin signo
  SLTI: Establecer si menor que inmediato (con signo)
  SLTIU: Establecer si menor que inmediato (sin signo)
  ANDI: AND inmediato
  ORI: OR inmediato
  LUI: Cargar inmediato superior
  LW: Cargar palabra
  SW: Almacenar palabra
  BEQ: Salto si igual
  BNE: Salto si no igual
"""
        i_type_label = ttk.Label(
            i_type_tab, 
            text=i_type_info,
            font=('Consolas', 9),
            background='#34495E',
            foreground='#BDC3C7',
            justify=tk.LEFT
        )
        i_type_label.pack(fill=tk.BOTH, padx=5, pady=5)
        
        # Pestaña de instrucciones Tipo J
        j_type_tab = ttk.Frame(notebook)
        notebook.add(j_type_tab, text="Tipo J")
        
        j_type_info = """
Formato: OP DIRECCION
Ejemplo: J 0x00400000

OPCODE: Código de operación (6 bits)
DIRECCION: Dirección de salto (26 bits)

Instrucciones:
  J: Salto incondicional
  JAL: Salto y enlace (para llamadas a función)
"""
        j_type_label = ttk.Label(
            j_type_tab, 
            text=j_type_info,
            font=('Consolas', 9),
            background='#34495E',
            foreground='#BDC3C7',
            justify=tk.LEFT
        )
        j_type_label.pack(fill=tk.BOTH, padx=5, pady=5)
    
    def browse_file(self):
        filename = filedialog.asksaveasfilename(
            defaultextension=".txt",
            filetypes=[("Text files", "*.txt"), ("All files", "*.*")],
            title="Guardar código máquina como..."
        )
        if filename:
            self.file_path.delete(0, tk.END)
            self.file_path.insert(0, filename)
    
    def clean_operand(self, operand):
        """Limpia el operando removiendo # y espacios"""
        return operand.strip().lstrip('#')
    
    def parse_immediate(self, text, bits=16, signed=True):
        """
        Convierte un inmediato (decimal o hex) a binario de 'bits' bits.
        Soporta negativos usando complemento a dos.
        Ejemplos válidos: 10, -4, 0x10, -0x4, #10, #-4
        """
        s = self.clean_operand(text)

        try:
            # base 0 -> acepta 10, -4, 0x10, -0x4, 0b1010, etc.
            val = int(s, 0)
        except ValueError:
            raise ValueError(f"Inmediato no válido: {text}")

        if signed:
            min_val = -(1 << (bits - 1))
            max_val =  (1 << (bits - 1)) - 1
            if val < min_val or val > max_val:
                raise ValueError(
                    f"Inmediato fuera de rango ({min_val}..{max_val}) "
                    f"para {bits} bits: {val}"
                )
        else:
            if val < 0 or val > (1 << bits) - 1:
                raise ValueError(
                    f"Inmediato sin signo fuera de rango (0..{(1<<bits)-1}) "
                    f"para {bits} bits: {val}"
                )

        # Máscara a 'bits' bits → complemento a dos automático
        return format(val & ((1 << bits) - 1), f'0{bits}b')
    
    def get_register_binary(self, register):
        """Obtiene la representación binaria de un registro"""
        reg_clean = register.strip().lower()
        
        # Primero buscar en el diccionario
        if reg_clean in REGISTERS:
            return REGISTERS[reg_clean]
        
        # Si no está, intentar manejar registros con números directamente
        if reg_clean.startswith('$'):
            reg_num_str = reg_clean[1:]
            try:
                reg_num = int(reg_num_str)
                if 0 <= reg_num <= 31:
                    return f"{reg_num:05b}"
            except ValueError:
                # Si no es un número, podría ser un alias no reconocido
                pass
        
        raise ValueError(f"Registro no válido: {register}")
    
    def parse_instruction(self, line):
        """Parsea una línea de instrucción y devuelve los componentes"""
        parts = [part.strip().rstrip(',') for part in line.split() if part.strip()]
        if not parts:
            return None
            
        instr = parts[0].lower()
        operands = parts[1:]
        
        return instr, operands
    
    def translate(self):
        asm_code = self.input_text.get("1.0", tk.END).strip()
        lines = asm_code.split('\n')
        output = []
        
        for line_num, line in enumerate(lines, 1):
            original_line = line
            line = line.strip()
            if not line or line.startswith('//'):
                continue
                
            # Eliminar comentarios al final de la línea
            if '//' in line:
                line = line.split('//')[0].strip()
            
            try:
                parsed = self.parse_instruction(line)
                if not parsed:
                    continue
                    
                instr, operands = parsed
                
                if instr in ['j', 'jal']:  # Tipo J
                    binary = self.translate_j_type(instr, operands)
                elif instr in ['beq', 'bne']:  # Tipo I (branch)
                    binary = self.translate_branch(instr, operands)
                elif instr in ['lw', 'sw']:  # Tipo I (load/store)
                    binary = self.translate_memory(instr, operands)
                elif instr in ['addi', 'addiu', 'slti', 'sltiu', 'andi', 'ori']:  # Tipo I (inmediato)
                    binary = self.translate_imm(instr, operands)
                elif instr == 'lui':  # Tipo I (lui)
                    binary = self.translate_lui(instr, operands)
                else:  # Tipo R
                    binary = self.translate_r_type(instr, operands)
                    
                hex_code = self.binary_to_hex(binary)
                binary_spaced = binary  # si luego quieres agrupar en bytes, lo puedes cambiar aquí
                output.append(f"{hex_code} | {binary_spaced} | // {original_line.strip()}")
                
            except Exception as e:
                output.append(f"❌ Error en línea {line_num}: {original_line.strip()} - {str(e)}")
        
        self.output_text.delete("1.0", tk.END)
        if output:
            self.output_text.insert("1.0", "\n".join(output))
            success_count = len([x for x in output if 'Error' not in x])
            messagebox.showinfo(
                "Traducción Completada", 
                f"Se tradujeron {success_count} instrucciones correctamente!"
            )
        else:
            self.output_text.insert("1.0", "No se encontraron instrucciones para traducir.")
    
    def translate_j_type(self, op, operands):
        if len(operands) != 1:
            raise ValueError(f"Instrucción {op} requiere 1 operando")
            
        opcode = OPCODES[op]
        # Dirección absoluta (26 bits, sin signo)
        addr_bin = self.parse_immediate(operands[0], bits=26, signed=False)
        return opcode + addr_bin
    
    def translate_branch(self, op, operands):
        if len(operands) != 3:
            raise ValueError(f"Instrucción {op} requiere 3 operandos")
            
        opcode = OPCODES[op]
        rs = self.get_register_binary(operands[0])
        rt = self.get_register_binary(operands[1])
        # offset de 16 bits con signo
        immediate = self.parse_immediate(operands[2], bits=16, signed=True)
        return opcode + rs + rt + immediate
    
    def translate_memory(self, op, operands):
        if len(operands) != 2:
            raise ValueError(f"Instrucción {op} requiere 2 operandos")
            
        opcode = OPCODES[op]
        rt = self.get_register_binary(operands[0])
        
        # Separar offset(rs)
        memory_part = operands[1]
        if '(' in memory_part and ')' in memory_part:
            offset_part, rs_part = memory_part.split('(')
            rs_part = rs_part.rstrip(')')
            offset = self.clean_operand(offset_part)
            rs = self.get_register_binary(rs_part)
        else:
            raise ValueError(f"Formato de memoria incorrecto: {memory_part}")
        
        # Offset de 16 bits con signo
        offset_bin = self.parse_immediate(offset, bits=16, signed=True)
        return opcode + rs + rt + offset_bin
    
    def translate_imm(self, op, operands):
        if len(operands) != 3:
            raise ValueError(f"Instrucción {op} requiere 3 operandos")
            
        opcode = OPCODES[op]
        rt = self.get_register_binary(operands[0])
        rs = self.get_register_binary(operands[1])

        # ADDI, ADDIU, SLTI, SLTIU → tratamos el inmediato como con signo
        # ANDI, ORI → típicamente cero-extensibles; aquí los dejamos sin signo
        signed_ops   = {'addi', 'addiu', 'slti', 'sltiu'}
        unsigned_ops = {'andi', 'ori'}

        if op in unsigned_ops:
            imm_bin = self.parse_immediate(operands[2], bits=16, signed=False)
        else:
            imm_bin = self.parse_immediate(operands[2], bits=16, signed=True)

        return opcode + rs + rt + imm_bin
    
    def translate_lui(self, op, operands):
        if len(operands) != 2:
            raise ValueError(f"Instrucción {op} requiere 2 operandos")
            
        opcode = OPCODES[op]
        rt = self.get_register_binary(operands[0])
        imm_bin = self.parse_immediate(operands[1], bits=16, signed=False)
        return opcode + '00000' + rt + imm_bin
    
    def translate_r_type(self, op, operands):
        opcode = OPCODES[op]
        
        if op == 'jr':  # jr rs
            if len(operands) != 1:
                raise ValueError("Instrucción jr requiere 1 operando")
            rs = self.get_register_binary(operands[0])
            return opcode + rs + '000000000000000' + FUNCTS[op]
            
        elif op in ['sll', 'srl']:  # sll/srl rd, rt, shamt
            if len(operands) != 3:
                raise ValueError(f"Instrucción {op} requiere 3 operandos")
            rd = self.get_register_binary(operands[0])
            rt = self.get_register_binary(operands[1])
            shamt = self.parse_immediate(operands[2], bits=5, signed=False)
            return opcode + '00000' + rt + rd + shamt + FUNCTS[op]
            
        else:  # add, sub, etc. - rd, rs, rt
            if len(operands) != 3:
                raise ValueError(f"Instrucción {op} requiere 3 operandos")
            rd = self.get_register_binary(operands[0])
            rs = self.get_register_binary(operands[1])
            rt = self.get_register_binary(operands[2])
            return opcode + rs + rt + rd + '00000' + FUNCTS[op]
    
    def binary_to_hex(self, binary):
        return hex(int(binary, 2))[2:].zfill(8).upper()
    
    def save_file(self):
        """
        Guarda el archivo en formato:
        - 4 líneas de 8 bits por cada instrucción de 32 bits (big endian)
        Esto es lo que espera tu InstructionMemory:
            reg [7:0] MEM[0:...];
            $readmemb("instructions.txt", MEM);
        """
        content = self.output_text.get("1.0", tk.END).strip()
        filepath = self.file_path.get().strip()
        
        if not filepath:
            messagebox.showerror("Error", "❌ Por favor, seleccione un archivo de destino")
            return
        
        # Primero obtenemos las instrucciones en binario (32 bits) desde la salida
        instr_bins = []
        for line in content.splitlines():
            line = line.strip()
            if not line or line.startswith("❌"):
                continue
            
            # Esperamos formato: HEX | BIN | // comentario
            if '|' in line:
                parts = line.split('|')
                if len(parts) >= 2:
                    bin_part = parts[1].strip()
                    bin_part = bin_part.replace(" ", "")
                    if all(c in '01' for c in bin_part) and len(bin_part) > 0:
                        instr_bins.append(bin_part)
        
        if not instr_bins:
            messagebox.showerror(
                "Error",
                "❌ No se encontraron líneas válidas de binario para guardar.\n"
                "Asegúrate de haber traducido instrucciones sin errores."
            )
            return
        
        # Convertir cada instrucción de 32 bits en 4 bytes (8 bits) big endian
        byte_lines = []
        for instr in instr_bins:
            # Asegurarnos que tenga exactamente 32 bits
            if len(instr) != 32:
                messagebox.showerror(
                    "Error",
                    f"❌ Se encontró una instrucción con {len(instr)} bits en lugar de 32.\n"
                    "Revisa tu salida antes de guardar."
                )
                return
            
            # Big endian: [31:24], [23:16], [15:8], [7:0]
            byte_lines.append(instr[0:8])
            byte_lines.append(instr[8:16])
            byte_lines.append(instr[16:24])
            byte_lines.append(instr[24:32])
        
        try:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write("\n".join(byte_lines))
            messagebox.showinfo(
                "Éxito",
                "✅ Archivo guardado correctamente (4 líneas de 8 bits por instrucción)."
            )
        except Exception as e:
            messagebox.showerror("Error", f"❌ No se pudo guardar: {str(e)}")


if __name__ == "__main__":
    # Crear ventana con tema más simple para mejor rendimiento
    root = ThemedTk(theme="clam")  # Tema más rápido
    app = MIPSTranslator(root)
    root.mainloop()