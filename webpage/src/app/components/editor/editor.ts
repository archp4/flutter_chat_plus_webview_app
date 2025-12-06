import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-editor',
  imports: [CommonModule, FormsModule],
  templateUrl: './editor.html',
  styleUrl: './editor.css',
})
export class Editor {
  editorContent: string = '# You can type here!!';
  currentView: 'edit' | 'preview' = 'edit';
  saveStatus: string = '';

  saveArticle(): void {
    console.log('Saving article:', this.editorContent);
    this.saveStatus = 'Article saved successfully!';
    setTimeout(() => (this.saveStatus = ''), 3000); // Clear status after 3 seconds
  }
}
